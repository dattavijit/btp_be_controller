const cds = require("@sap/cds");

module.exports = cds.service.impl(srv => {

  srv.before('READ', 'Assessments', (req) => {
    console.log('Before')
  })

  srv.after('READ', 'Assessments', (results) => {
    console.log('After')
  })

  srv.on('READ', 'Assessments', (req) => {
    console.log('On')
  })

})



