pageextension 50502 CustomerListExtension extends "Customer List"
{

    layout
    {
        addlast(Control1)
        {
            field("Customer Type"; Rec."Customer Type")
            {
                ApplicationArea = All;
                Caption = 'Customer Type';
            }
            field("Business Unit"; Rec."Business Unit")
            {
                ApplicationArea = All;
                Caption = 'Business unit';
                Editable = false;
            }
        }
        // Add changes to page layout here
    }
    // trigger OnOpenPage();
    // var
    //     ModuleSetup: Record "Module Setup";
    //     ActiveModuleName: Text[50];
    // begin
    //     // Find the active module
    //     if ModuleSetup.Get() and ModuleSetup."Is Active" then begin
    //         case ModuleSetup."Extension Name" of
    //             'Property Management':
    //                 Rec.SetRange("Customer Type", "Customer Type Enum"::Tenant);
    //             'Property Sales':
    //                 Rec.SetRange("Customer Type", "Customer Type Enum"::Buyer);
    //             else
    //                 Rec.Reset(); // Clear all filters if no module matches
    //         end;
    //     end else
    //         Rec.Reset(); // Clear all filters if no active module is found
    // end;

    trigger OnOpenPage()
    var
        ModuleSetup: Record "Module Setup";
        ActiveModuleName: Text[50];
    begin
        // Find the active module
        if ModuleSetup.FindSet() then begin
            repeat
                if ModuleSetup."Is Active" then begin
                    ActiveModuleName := ModuleSetup."Extension Name";

                end;
            until ModuleSetup.Next() = 0;

            // Apply filter based on active module
            case ActiveModuleName of
                'PROPERTY MANAGEMENT':
                    Rec.SetRange("Customer Type", "Customer Type Enum"::Tenant);
                'PROPERTY SALES':
                    Rec.SetRange("Customer Type", "Customer Type Enum"::Buyer);
                else
                    Rec.Reset(); // No active module found, clear filters
            end;
        end
        else begin
            Rec.Reset(); // No records in Module Setup, clear filters
        end;
    end;




    // actions
    // {
    //     // Add changes to page actions here
    //     addafter("Sales Journal")
    //     {
    //         action(FilterByActiveModule)
    //         {
    //             Caption = 'Filter by Active Module';
    //             ApplicationArea = All;
    //             trigger OnAction()
    //             var
    //                 ModuleSetup: Record "Module Setup";
    //                 ActiveModule: Code[50];
    //             begin
    //                 if ModuleSetup.FindSet() then
    //                     repeat
    //                         if ModuleSetup."Is Active" then
    //                             ActiveModule := ModuleSetup."Module Name";
    //                     until ModuleSetup.Next() = 0;

    //                 case ActiveModule of
    //                     'Property Management':
    //                         Rec.SetRange("Business Unit", 'PM');
    //                     'Property Sales':
    //                         Rec.SetRange("Business Unit", 'PS');
    //                     else
    //                         // Clear all filters if no active module
    //                         Rec.Reset(); // Correct way to clear filters
    //                 end;
    //             end;
    //         }
    //     }
    // }

    // trigger OnOpenPage()
    // var
    //     ExtensionSetup: Record "Module Setup";
    //     ActiveExtensionCode: Code[10];
    // begin
    //     // Get the active extension
    //     if ExtensionSetup.FindSet() then begin
    //         if ExtensionSetup."Is Active" then
    //             ActiveExtensionCode := ExtensionSetup."Extension Code";
    //     end;

    //     // Filter Customers based on the active extension
    //     Rec.SetRange("Business Unit", ActiveExtensionCode);
    // end;

    // trigger OnOpenPage()
    // var
    //     CurrentBusinessUnit: Code[10];
    //     BusinessUnit: Record "Business Unit";
    // begin
    //     if BusinessUnit.Get('PM') then
    //         CurrentBusinessUnit := 'PM'
    //     else if BusinessUnit.Get('PS') then
    //         CurrentBusinessUnit := 'PS';

    //     Rec.SetFilter("Business Unit", CurrentBusinessUnit);
    // end;

    var
        myInt: Integer;
}