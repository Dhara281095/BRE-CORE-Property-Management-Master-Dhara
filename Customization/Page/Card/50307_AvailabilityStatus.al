page 50307 "Availability Status Card"
{
    PageType = Card;
    SourceTable = "Availability Status";
    ApplicationArea = All;
    Caption = 'Availability Status Card';


    layout
    {
        area(content)
        {
            group(Group)
            {
                Caption = 'Availability Status';
                field("ID"; Rec."ID")
                {
                    ApplicationArea = All;
                    Editable = false; // The ID is not editable since it's auto-incrementing
                }
                field("Status"; Rec."Status")
                {
                    ApplicationArea = All;
                    Caption = 'Availability Status';
                    ToolTip = 'Enter the Availability Status name.';
                }
            }
        }
    }


}



