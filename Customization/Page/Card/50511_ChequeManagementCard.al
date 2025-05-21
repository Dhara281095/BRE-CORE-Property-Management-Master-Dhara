page 50511 "Cheque Mangement Card"
{
    PageType = Card;
    ApplicationArea = All;
    UsageCategory = Administration;
    SourceTable = "Cheque Table";
    Editable = true;

    layout
    {
        area(content)
        {
            group("General")
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