page 50326 "UserSettingAPI"
{
    PageType = API;
    SourceTable = "User Personalization";
    APIPublisher = 'RealestateDev';
    APIGroup = 'Approvalflow';
    APIVersion = 'v2.0';
    EntityName = 'userSetting';
    EntitySetName = 'userSettings';
    Caption = 'User Settings';

    DelayedInsert = true;
    DeleteAllowed = true;
    ModifyAllowed = true;

    layout
    {
        area(content)
        {
            field(UserSID; Rec."User SID") // System ID field for unique identification in API calls
            {
                Caption = 'System Identifier';
            }

            field(UserID; Rec."User ID")
            {

            }

            field(FullName; Rec."Full Name")
            {

            }

            field(ProfileID; Rec."Profile ID")
            {

            }

            field(Company; Rec.Company)
            {

            }

            field(Role; Rec.Role)
            {

            }




        }
    }
}
