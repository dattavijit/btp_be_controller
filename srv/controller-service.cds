using btp.conroller as b from '../db/data-model';
service ControllerService @( impl : './controller.js' ) {
    entity Assessments as select from b.Assessments ;

} 