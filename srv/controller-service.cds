using btp.conroller as b from '../db/data-model';

// annotation to define the service implementation
service ControllerService @(impl: './controller.js') {
    @odata.draft.enabled
    entity Assessments as select from b.Assessments;

}

// annotation for UI
//Agenda    : String(50);
//StartDate : Date;
//EndDate   : Date;
//DueDate   : Date;

annotate ControllerService.Assessments with @(UI: {

    LineItem             : [
        {
            $Type: 'UI.DataField',
            Value: Agenda,
        },
        {
            $Type: 'UI.DataField',
            Value: StartDate,

        },
        {
            $Type: 'UI.DataField',
            Value: EndDate
        },
        {
            $Type: 'UI.DataField',
            Value: DueDate
        }
    ],
    FieldGroup #BasicData: {
        $Type: 'UI.FieldGroupType',
        Data : [
            {
                $Type: 'UI.DataField',
                Value: Agenda,
            },
            {
                $Type: 'UI.DataField',
                Value: StartDate,

            },
            {
                $Type: 'UI.DataField',
                Value: EndDate
            },
            {
                $Type: 'UI.DataField',
                Value: DueDate
            },
            {
                $Type: 'UI.DataField',
                Value: DaysPlanned,
            },
        ],
    },
    Facets               : [{
        $Type : 'UI.ReferenceFacet',
        Target: '@UI.FieldGroup#BasicData',
        Label : 'Basic Data'
    }, ],
}) {
    Agenda      @title: 'Agenda';
    StartDate   @title: 'Start Date';
    EndDate     @title: 'End Date';
    DueDate     @title: 'Due Date';
    DaysPlanned @title: '{i18n>DaysPlanned}';
};
