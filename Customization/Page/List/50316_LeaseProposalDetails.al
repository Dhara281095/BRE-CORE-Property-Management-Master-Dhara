page 50316 "Lease Proposal List"
{
    PageType = List;
    ApplicationArea = All;
    SourceTable = "Lease Proposal Details";
    Caption = 'Lease Proposals';
    CardPageId = 50315;
    UsageCategory = Lists;

    layout
    {

        area(content)
        {
            repeater(Group)
            {
                field("Proposal ID"; Rec."Proposal ID")
                {
                    ApplicationArea = All;
                }

                field("Unit ID"; rec."Unit ID")
                {
                    ApplicationArea = All;

                }

                field("Merge Unit ID"; Rec."Merge Unit ID")
                {
                    ApplicationArea = All;

                }

                field("Property Name"; rec."Property Name")
                {
                    ApplicationArea = All;
                    Caption = 'Property Name';
                }

                field("Property Address"; Rec."Unit Address")
                {
                    ApplicationArea = All;
                }
                field("Tenant Full Name"; Rec."Tenant Full Name")
                {
                    ApplicationArea = All;
                }
                field("Rent Amount"; Rec."Rent Amount")
                {
                    ApplicationArea = All;

                }
                field("Lease Start Date"; Rec."Lease Start Date")
                {
                    ApplicationArea = All;

                }
                field("Lease End Date"; Rec."Lease End Date")
                {
                    ApplicationArea = All;

                }

                field("Property Size"; Rec."Unit Size")
                {
                    ApplicationArea = All;

                }
                field("Proposal Status"; rec."Proposal Status")
                {
                    ApplicationArea = All;
                }

                field("License No."; Rec."License No.")
                {
                    ApplicationArea = All;
                }

                field("Licensing Authority"; Rec."Licensing Authority")
                {
                    ApplicationArea = All;
                }
            }
        }
    }

    // actions
    // {
    //     area(processing)
    //     {
    //         action("New Lease Proposal")
    //         {
    //             Caption = 'New Lease Proposal';
    //             ApplicationArea = All;
    //             Image = New;
    //             Promoted = true;
    //             PromotedCategory = Process;
    //             trigger OnAction()
    //             begin
    //                 CreateRecord();
    //             end;
    //         }
    //     }
    // }

    // procedure CreateRecord()
    // var
    //     LeaseProposal: Record "Lease Proposal Details";
    // begin
    //     LeaseProposal.Init();
    //     if Page.RunModal(Page::"Lease Proposal Card", LeaseProposal) = Action::OK then
    //         LeaseProposal.Insert(true);
    // end;
}

