namespace btp.conroller;

using {
    cuid,
    managed
} from '@sap/cds/common';

// Entity - Table
// Entity - Existing View/synonym
// Entity - Custom ENtity

entity Assessments : cuid {
    Agenda                           : String(50)  @mandatory  @Core.Immutable;
    StartDate                        : Date        @mandatory;
    EndDate                          : Date        @mandatory;
    DueDate                          : Date        @mandatory;
    DaysPlanned                      : Integer     @assert.range: [
        7,
        21
    ];

    virtual OverallStatus            : String(50);
    virtual OverallStatusCriticality : Integer;
}

@cds.persistence.skip
entity V_ASSESSMENTS : cuid {
    AgendaIndex : Integer;
    Agenda      : String(50);
    StartDate   : Date;
    EndDate     : Date;
    DueDate     : Date;
    DaysPlanned : Integer;
}
