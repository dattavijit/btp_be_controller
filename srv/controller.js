const cds = require("@sap/cds");
const actionHandlers = require("./actionHandlers");

module.exports = cds.service.impl(srv => {

  srv.on('MarkAsObsolete', actionHandlers.MarkAsObsolete); 


  srv.before('CREATE', 'Assessments', (req) => {
    console.log('Before Create');

    // if start date is higher than end date, reject the request
    if (req.data.StartDate > req.data.EndDate) {
      req.error(400, 'Start date must be before end date', 'in/StartDate');
    }

    // if due date is before start date  or before end date reject request
    if (req.data.DueDate < req.data.StartDate || req.data.DueDate < req.data.EndDate) {
      req.error(400, 'Due date must be after start and end date', 'in/DueDate');
    }

  })


  srv.before('READ', 'Assessments', (req) => {
    console.log('Before Read');
  })

  srv.on('READ', 'Assessments', (req, next) => {
    return next();
  })

  srv.after('READ', 'Assessments', (data, req) => {
    console.log('After Read');
    //if results is not empty, add a new property to each result
    if (typeof data.length !== 'undefined' && data.length > 0) {
      data.forEach(item => {
        let ls_status_info = _CalculateStatus(item);
        item.OverallStatus = ls_status_info.OverallStatus;
        item.OverallStatusCriticality = ls_status_info.OverallStatusCriticality;
      });
    }
  })

  srv.on('READ', 'AssessmentsView', async (req) => {
    const { Assessments } = cds.entities('btp.conroller');

    const tx = cds.transaction(req);

    let aAssessments = await tx.run(
      SELECT.from(Assessments));

    var aOutputData = [], sAgendaIndex = 0;

    aAssessments.forEach(lv_assessment => {
      sAgendaIndex++;
      aOutputData.push({
        "AgendaIndex": sAgendaIndex,
        "ID": lv_assessment.ID,
        "Agenda": lv_assessment.Agenda,
        "StartDate": lv_assessment.StartDate,
        "EndDate": lv_assessment.EndDate,
        "DueDate": lv_assessment.DueDate,
        "DaysPlanned": lv_assessment.DaysPlanned

      })
    });
    return aOutputData;
    console.log(aOutputData);
  })


  //Create a function to calculate the status of the assessment
  function _CalculateStatus(assessment) {
    if (!assessment.StartDate || !assessment.EndDate || !assessment.DueDate) {
      return { "OverallStatus": 'Not Started', "OverallStatusCriticality": 0 };
    } else {

      let lv_today = new Date();
      lv_today.setHours(0, 0, 0, 0);

      let lv_due_date = new Date(assessment.DueDate);
      lv_due_date.setHours(0, 0, 0, 0);

      return (lv_due_date < lv_today) ? { "OverallStatus": 'Overdue', "OverallStatusCriticality": 1 } :
        { "OverallStatus": 'On Track', "OverallStatusCriticality": 3 }

    }
  }
});