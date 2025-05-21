page 50325 "All Profile API"
{
    PageType = API;
    SourceTable = "All Profile";
    APIPublisher = 'RealestateDev';
    APIGroup = 'Approvalflow';
    APIVersion = 'v2.0';
    EntityName = 'AllProfile';
    EntitySetName = 'AllProfiles';
    Caption = 'All Profile';
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

            field(ProfileID; Rec."Profile ID")
            {

            }

            field(RoleCenterID; Rec."Role Center ID")
            {

            }


        }
    }
}
