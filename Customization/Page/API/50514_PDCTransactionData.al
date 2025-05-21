page 50514 "PDC Transaction Data"
{
    PageType = API;
    APIGroup = 'Finance';
    APIPublisher = 'RealeststeDev';
    APIVersion = 'v2.0';
    ApplicationArea = All;
    Caption = 'PDC Transaction API';
    DelayedInsert = true;
    EntityName = 'PDCTransaction';
    EntitySetName = 'PDCTransactions';
    ODataKeyFields = SystemId; // Ensure the SystemId is exposed in the API
    SourceTable = "PDC Transaction";

    layout
    {
        area(Content)
        {
            repeater(Group)
            {
                field("PDC_ID"; Rec."PDC ID") { }
                field(SystemId; Rec.SystemId) { }
                field("Tenant_Id"; Rec."Tenant Id") { }
                field("Contract_ID"; Rec."Contract ID") { }
                field("Bank_Name"; Rec."Bank Name") { }
                field("Cheque_Number"; Rec."Cheque Number") { }
                field("Cheque_Date"; Rec."Cheque Date") { }
                field(Amount; Rec.Amount) { }
                field("Cheque_Status"; Rec."Cheque Status") { }
                field("Approval_Status"; Rec."Approval Status") { }
                field(View; Rec.View) { }

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