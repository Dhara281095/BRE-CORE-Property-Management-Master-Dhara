page 50314 "Tenancy Contract List"
{
    PageType = List;
    ApplicationArea = All;
    SourceTable = "Tenancy Contract";
    Caption = 'Tenancy Contract List';
    UsageCategory = Lists;
    CardPageId = 50313;

    layout
    {
        area(content)
        {
            repeater(Group)
            {

                field("Contract ID"; rec."Contract ID")
                {
                    ApplicationArea = All;
                    Caption = 'Contract ID';
                }
                field("Proposal ID"; rec."Proposal ID")
                {
                    ApplicationArea = All;
                    Caption = 'Proposal ID';
                }

                field("Renewal Proposal ID"; Rec."Renewal Proposal ID")
                {
                    ApplicationArea = All;
                }

                field("Property ID"; rec."Property ID")
                {
                    ApplicationArea = All;
                }

                field("Unit ID"; rec."Unit ID")
                {
                    ApplicationArea = All;
                    Caption = 'Single Unit ID';
                }

                field("Merge ID"; rec."Merge Unit ID")
                {
                    ApplicationArea = All;
                }
                field("Property Name"; rec."Property Name")
                {
                    ApplicationArea = All;
                    Caption = 'Property Name';
                }

                field("Tenant ID"; rec."Tenant ID")
                {
                    ApplicationArea = All;
                }

                field("Customer Name"; rec."Customer Name")
                {
                    ApplicationArea = All;
                    Caption = 'Customer Name';
                }
                // field("Unit Type"; rec."Unit Type")
                // {
                //     ApplicationArea = All;
                //     Caption = 'Unit Type';
                // }
                field("Annual Rent Amount"; rec."Annual Rent Amount")
                {
                    ApplicationArea = All;
                    Caption = 'Annual Rent Amount ';
                }
                field("Contract Start Date"; rec."Contract Start Date")
                {
                    ApplicationArea = All;
                    Caption = 'Start Date';
                }
                field("Contract End Date"; rec."Contract End Date")
                {
                    ApplicationArea = All;
                    Caption = 'End Date';
                }

                field("Update Contract Status"; rec."Update Contract Status")
                {
                    ApplicationArea = All;
                    Caption = 'Update Contract Status';
                }

                field("Tenant Contract Status"; rec."Tenant Contract Status")
                {
                    ApplicationArea = All;
                    Caption = 'Tenant Contract Status';
                }

                // field("ID"; rec."ID")
                // {
                //     ApplicationArea = All;
                //     Caption = 'Suspended Reason ID';

                //     trigger OnDrillDown()
                //     var
                //         SuspendReasonRec: Record "SuspendReasonTable"; // Replace with actual table name
                //     begin
                //         if SuspendReasonRec.Get(rec."ID") then
                //             PAGE.RunModal(PAGE::"Suspend Reason Card", SuspendReasonRec) // Replace with actual card page
                //         else
                //             Error('No related record found in Suspend Reason Table with ID: %1', rec."ID");
                //     end;
                // }

            }
        }
    }

    // actions
    // {
    //     area(processing)
    //     {
    //         action("Create New Contract")
    //         {
    //             ApplicationArea = All;
    //             Caption = 'Create New Contract';
    //             trigger OnAction()
    //             begin
    //                 PAGE.RunModal(PAGE::"Tenancy Contract Card");
    //             end;
    //         }
    //     }
    // }
}
