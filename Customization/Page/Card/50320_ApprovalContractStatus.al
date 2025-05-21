page 50320 "Approval Contract Status Card"
{
    PageType = Card;
    SourceTable = "Approval Contract Status";
    ApplicationArea = All;
    Caption = 'Approval Contract Status Card';

    layout
    {
        area(content)
        {
            group(General)
            {
                field("ID"; Rec."ID")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Status"; Rec."Status")
                {
                    ApplicationArea = All;
                }
                field("Contract ID"; Rec."Contract ID")
                {
                    ApplicationArea = All;
                }
                field("Lease ID"; Rec."Lease ID")
                {
                    ApplicationArea = All;
                }

                field("Tenancy Contract Status"; Rec."Tenancy Contract Status")
                {
                    ApplicationArea = All;
                }
            }
        }
    }

    actions
    {
        area(processing)
        {
            // You can add actions here if needed
        }
    }
}
