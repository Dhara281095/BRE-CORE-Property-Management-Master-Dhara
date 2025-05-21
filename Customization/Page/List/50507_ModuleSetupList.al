page 50507 "Module Setup List"
{
    PageType = List;
    ApplicationArea = All;
    SourceTable = "Module Setup";
    Caption = 'Module Setup List';

    UsageCategory = Lists;

    layout
    {
        area(Content)
        {

            // group("Module Activation")
            // {
            //     field("Property Management Active"; Rec."Property Management Active")
            //     {
            //         ToolTip = 'Activate or deactivate Property Management.';
            //     }
            //     field("Property Sales Active"; Rec."Property Sales Active")
            //     {
            //         ToolTip = 'Activate or deactivate Property Sales.';
            //     }
            // }
            repeater(General)
            {

                // field("Module Name"; Rec."Extension Name")
                // {
                //     ApplicationArea = All;
                // }
                // field("Is Active"; Rec."Is Active")
                // {
                //     ApplicationArea = All;
                // }


                field("Extension Name"; Rec."Extension Name")
                {
                    Caption = 'Module Name';
                    ApplicationArea = All;
                }
                field("Is Active"; Rec."Is Active")
                {
                    Caption = 'Is Active';
                    ApplicationArea = All;
                }

            }
        }
    }


    // actions
    // {
    //     area(Processing)
    //     {
    //         action(SetActiveExtension)
    //         {
    //             Caption = 'Set Active Extension';
    //             ApplicationArea = All;

    //             trigger OnAction()
    //             var
    //                 ExtensionSetup: Record "Module Setup";
    //             begin
    //                 if Rec.FindSet() then begin
    //                     repeat
    //                         Rec."Is Active" := false; // Reset all extensions
    //                         Rec.Modify();
    //                     until Rec.Next() = 0;

    //                     Rec."Is Active" := true; // Set the selected extension as active
    //                     Rec.Modify();
    //                     Message('Active Extension set to: %1', Rec."Extension Name");
    //                 end;
    //             end;
    //         }
    //     }
    // }

    trigger OnOpenPage()
    var
        ModuleSetupRec: Record "Module Setup";
    begin
        // Check if the record exists using the primary key
        if not ModuleSetupRec.Get('SETUP') then begin
            ModuleSetupRec.Init();
            ModuleSetupRec."Module Name" := 'SETUP'; // Assign the primary key
            ModuleSetupRec.Insert();
        end;
    end;

    var
        myInt: Integer;
}