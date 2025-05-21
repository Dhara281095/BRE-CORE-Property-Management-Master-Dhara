page 50510 "Cheque Management List"
{
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = "Cheque Table";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Cheque ID"; Rec."ChequeID") { }
                field("Lease ID"; Rec."LeaseID") { }
                field("Cheque Date"; Rec."ChequeDate") { }
                field("Cheque Amount"; Rec."ChequeAmount") { }
                field("Cheque Status"; Rec."ChequeStatus")
                {

                }
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