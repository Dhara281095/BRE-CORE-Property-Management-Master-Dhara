page 50515 "Payment Transaction List"
{
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Lists;
    Caption = 'Payment Transaction List';
    SourceTable = "Payment Transaction";
    CardPageId = 50516;

    layout
    {
        area(Content)
        {
            repeater(Group)
            {
                field("PT Id"; Rec."PT Id") { }
                field("Tenant Id"; Rec."Tenant Id") { }
                field("Tenant Name"; Rec."Tenant Name") { }
                field("Contract Id"; Rec."Contract Id") { }
                field("Approval Status"; Rec."Approval Status") { }
            }
        }
    }

    actions
    {
        area(Processing)
        {
            action(ActionName)
            {

                trigger OnAction()
                begin

                end;
            }
        }
    }

    var
        myInt: Integer;
}