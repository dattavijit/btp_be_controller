namespace btp.conroller;

using {
    cuid,
    managed
} from '@sap/cds/common';

// Entity - Table
// Entity - Existing View/synonym
// Entity - Custom ENtity

entity Assessments : cuid {
    Agenda    : String(50)  @mandatory  @Core.Immutable;
    StartDate : Date        @mandatory;
    EndDate   : Date        @mandatory;
    DueDate   : Date        @mandatory;

}
