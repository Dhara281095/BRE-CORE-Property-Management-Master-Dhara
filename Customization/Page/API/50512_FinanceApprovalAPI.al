page 50512 "FinanceApprovalAPI"
{
    APIGroup = 'Finance';
    APIPublisher = 'RealeststeDev';
    APIVersion = 'v2.0';
    ApplicationArea = All;
    Caption = 'PDC Approval API';
    DelayedInsert = true;
    EntityName = 'PDCApproval';
    EntitySetName = 'PDCApprovals';
    PageType = API;
    ODataKeyFields = SystemId; // Ensure the SystemId is exposed in the API
    SourceTable = "PDC Approval";


    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field(Id; Rec.Id) { }
                field(SystemId; Rec.SystemId) { }
                field(Status; Rec.Status) { }
                field("PDC_Id"; Rec."PDC Id") { }
                field(Tenant_Id; Rec.Tenant_Id) { }
                field(Contract_Id; Rec.Contract_Id) { }
                field(Check_No; Rec.Check_No) { }
                field(Deposite_Bank; Rec.Deposite_Bank) { }
                field(Total_Amount; Rec.Total_Amount) { }
                field(Due_Date; Rec.Due_Date) { }
                field(View; Rec.View) { }
                // Add other fields that should be exposed via the API
            }
        }
    }



    var
        myInt: Integer;
}