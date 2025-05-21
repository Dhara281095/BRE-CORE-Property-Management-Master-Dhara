page 50324 "UsersAPI"
{
    PageType = API;
    SourceTable = "User";
    APIPublisher = 'RealestateDev';
    APIGroup = 'Approvalflow';
    APIVersion = 'v2.0';
    EntityName = 'User';
    EntitySetName = 'Users';
    Caption = 'Users';
    ODataKeyFields = SystemId;
    DelayedInsert = true;
    DeleteAllowed = true;
    ModifyAllowed = true;

    layout
    {
        area(content)
        {
            field("systemId"; Rec.systemId) // System ID field for unique identification in API calls
            {
                Caption = 'systemId';
            }

            field("UserSecurityID"; Rec."User Security ID") // System ID field for unique identification in API calls
            {
                Caption = 'System Identifier';
            }


            field(UserName; Rec."User Name")
            {

            }

            field(FullName; Rec."Full Name")
            {

            }

            field(State; Rec."State")
            {

            }

            field("ExpiryDate"; Rec."Expiry Date")
            {

            }

            field(ContactEmail; Rec."Contact Email")
            {

            }


        }
    }
}
