const cds = require("@sap/cds");

module.exports = cds.service.impl(srv => {

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

  //srv.after('READ', 'Assessments', (results) => {
  //  console.log('After')
  // })

  //srv.on('READ', 'Assessments', (req) => {
  //  console.log('On')
  //})

})



