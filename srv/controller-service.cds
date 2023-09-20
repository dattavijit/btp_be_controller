using btp.conroller as b from '../db/data-model';

// annotation to define the service implementation
service ControllerService @(impl: './controller.js') {
    @odata.draft.enabled
    entity Assessments     as select from b.Assessments actions {
                                  action MarkAsObsolete(reason : String(50));
                              };

    @readonly
    entity AssessmentsView as select from b.V_ASSESSMENTS;

    entity MediaFile       as select from b.MediaFile;

}

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
        },
        {
            $Type: 'UI.DataField',
            Value: DaysPlanned
        },
        {
            $Type      : 'UI.DataField',
            Value      : OverallStatus,
            Criticality: OverallStatusCriticality
        },
        {
            $Type: 'UI.DataField',
            Value: IsObsolete
        },
        {
            $Type : 'UI.DataFieldForAction',
            Action: 'ControllerService.MarkAsObsolete',
            Label : 'Mark as Obsolete'
        },
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
                $Type      : 'UI.DataField',
                Value      : OverallStatus,
                Criticality: OverallStatusCriticality
            },
        ],
    },
    Facets               : [{
        $Type : 'UI.ReferenceFacet',
        Target: '@UI.FieldGroup#BasicData',
        Label : 'Basic Data'
    }, ],
}) {
    Agenda        @title: 'Agenda';
    StartDate     @title: 'Start Date';
    EndDate       @title: 'End Date';
    DueDate       @title: 'Due Date';
    DaysPlanned   @title: '{i18n>DaysPlanned}';
    OverallStatus @title: 'Overall Status';
    IsObsolete    @title: 'Is Obsolete';
};
