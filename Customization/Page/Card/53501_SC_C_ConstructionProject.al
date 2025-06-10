page 53501 "Construction Project"
{
    PageType = Card;
    SourceTable = "Construction Project";
    ApplicationArea = All;
    Caption = 'Construction Project Card';
    UsageCategory = Administration;
    layout
    {
        area(Content)
        {
            group(Group)
            {
                Caption = 'Project Details';
                field("Project ID"; Rec."Project ID")
                {
                    ApplicationArea = All;

                }
                field("Project Name"; Rec."Project Name")
                {
                    ApplicationArea = All;


                }
                field("Project Location"; Rec."Project Location")
                {
                    ApplicationArea = All;


                }
                field("Project Scope"; Rec."Project Scope")
                {
                    ApplicationArea = All;


                }
                field("Project Start Date"; Rec."Project Start Date")
                {
                    ApplicationArea = All;


                }
                field("Project End Date"; Rec."Project End Date")
                {
                    ApplicationArea = All;


                }
                field("Project Status"; Rec."Project Status")
                {
                    ApplicationArea = All;

                }


            }
            group("Milestone Details")
            {
                Caption = 'Milestone Details';
                field("Milestone No."; Rec."Milestone ID")
                {
                    ApplicationArea = All;

                }
                field("Milestone Name"; Rec."Milestone Name")
                {
                    ApplicationArea = All;

                }
                field("Milestone Start Date"; Rec."Milestone Start Date")
                {
                    ApplicationArea = All;

                }
                field("Milestone End Date"; Rec."Milestone End Date")
                {
                    ApplicationArea = All;

                }
            }
            group("Task Details")
            {
                Caption = 'Task Details';
                field("Task No."; Rec."Task ID")
                {
                    ApplicationArea = All;

                }
                field("Task Name"; Rec."Task Name")
                {
                    ApplicationArea = All;

                }
                field("Task Start Date"; Rec."Task Start Date")
                {
                    ApplicationArea = All;

                }
                field("Task End Date"; Rec."Task End Date")
                {
                    ApplicationArea = All;

                }
            }
            group("Issue Tracking")
            {
                Caption = 'Issue Tracking';
                field("Issue No."; Rec."Issue ID")
                {
                    ApplicationArea = All;

                }
                field("Issue Description"; Rec."Issue Description")
                {
                    ApplicationArea = All;

                }
                field("Issue Status"; Rec."Issue Status")
                {
                    ApplicationArea = All;

                }
                field("Issue Notes"; Rec."Issue Notes")
                {
                    ApplicationArea = All;

                }
            }
            group("Progress Reporting")
            {
                Caption = 'Progress Reporting';
                field("Report ID"; Rec."Report ID")
                {
                    ApplicationArea = All;

                }
                field("Report Date"; Rec."Report Date")
                {
                    ApplicationArea = All;

                }
                field("Report Type"; Rec."Report Type")
                {
                    ApplicationArea = All;

                }
                field("Report File"; Rec."Report File")
                {

                    ApplicationArea = All;

                }
                field("Report Notes"; Rec."Report Notes")
                {
                    ApplicationArea = All;

                }
            }
        }
    }
}