page 50319 "Approval Contract Status API"
{
    PageType = API;
    SourceTable = "Approval Contract Status";
    APIPublisher = 'RealestateDev';
    APIGroup = 'Approvalflow';
    APIVersion = 'v2.0';
    EntityName = 'approvalContractStatus';
    EntitySetName = 'approvalContractStatuses';
    Caption = 'Approval Contract Status API';
    ODataKeyFields = SystemId;
    DelayedInsert = true;
    DeleteAllowed = true;
    ModifyAllowed = true;

    layout
    {
        area(content)
        {
            field("SystemId"; Rec.SystemId) // System ID field for unique identification in API calls
            {
                Caption = 'System Identifier';
            }

            field(ID; Rec."ID")
            {
            }

            field(Status; Rec."Status")
            {
            }

            field("ContractID"; Rec."Contract ID")
            {
            }

            field("LeaseID"; Rec."Lease ID")
            {
            }

            field("TenancyContractStatus"; Rec."Tenancy Contract Status")
            {
            }

            field("RenewalContractID"; Rec."Renewal Contract ID")
            {
            }



        }
    }
}
