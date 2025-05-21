page 50310 "Owner Profile List"
{
    PageType = List;
    SourceTable = "Owner Profile";
    ApplicationArea = All;
    Caption = 'Owner Profiles';
    UsageCategory = Lists;
    CardPageId = 50309;

    layout
    {
        area(Content)
        {
            repeater(Group)
            {
                field("Owner ID"; rec."Owner ID")
                {
                    ApplicationArea = All;
                }
                field("Full Name"; rec."Full Name")
                {
                    ApplicationArea = All;
                    Caption = 'Name';
                }
                field("Nationality"; rec."Nationality")
                {
                    ApplicationArea = All;
                }
                field("Phone Number"; rec."Phone Number")
                {
                    ApplicationArea = All;
                }
                field("Email Address"; rec."Email Address")
                {
                    ApplicationArea = All;
                }
                field("Status"; rec."Status")
                {
                    ApplicationArea = All;
                }

                field("Ejari Registration Number"; Rec."Ejari Registration Number")
                {
                    ApplicationArea = All;
                    Caption = 'Ejari Reg. No.';
                }
                field("RERA Owner ID"; Rec."RERA Owner ID")
                {
                    ApplicationArea = All;
                    Caption = 'RERA Owner ID';
                }
            }
        }
    }

    actions
    {
        area(Processing)
        {
            action(NewOwner)
            {
                Caption = 'New Owner';
                ApplicationArea = All;
                trigger OnAction()
                begin
                    Page.RunModal(Page::"Owner Profile Card");
                end;
            }
        }
    }
}
