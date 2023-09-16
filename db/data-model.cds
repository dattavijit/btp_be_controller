namespace btp.conroller;

using {
    cuid,
    managed
} from '@sap/cds/common';

// Entity - Table
// Entity - Existing View/synonym
// Entity - Custom ENtity

entity Assessments : cuid {
    Agenda    : String(50);
    StartDate : Date;
    EndDate   : Date;
    DueDate   : Date;
}
