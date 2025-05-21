page 50328 SuspendReasonList
{
    PageType = List;
    ApplicationArea = All;
    SourceTable = SuspendReasonTable;
    Caption = 'Suspend Reason List';
    CardPageId = 50327;

    UsageCategory = Lists;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field(ID; Rec.ID)
                {
                    ApplicationArea = All;
                }
                field(DateEffective; Rec.DateEffective)
                {
                    ApplicationArea = All;
                }
                field(Reason; Rec.Reason)
                {
                    ApplicationArea = All;
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = All;
                }

                field("Contract ID"; Rec."Contract ID")
                {
                    ApplicationArea = All;
                }

                field("Tenant Contract Status"; Rec."Tenant Contract Status")
                {
                    ApplicationArea = All;
                }
            }
        }
    }

    actions
    {
        area(Processing)
        {
            action(NewSuspendReason)
            {
                Caption = 'New Suspend Reason';
                ApplicationArea = All;
                Image = New;

                trigger OnAction()
                begin
                    PAGE.Run(PAGE::"Suspend Reason Card");
                end;
            }
        }
    }
}
