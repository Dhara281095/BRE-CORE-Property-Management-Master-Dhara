// page 50919 "Revenue Item SubPage Card2"
// {
//     PageType = ListPart;
//     ApplicationArea = All;
//     // UsageCategory = Administration;
//     SourceTable = "Revenue Item Subpage2";
//     Caption = 'One Time Payment Items';

//     layout
//     {
//         area(Content)
//         {
//             repeater(Group)
//             {

//                 field("Secondary Item Type"; Rec."Secondary Item Type")
//                 {
//                     ApplicationArea = All;
//                     Caption = 'Secondary Item Type';
//                     ToolTip = 'Enter the Secondary Item Type.';

//                 }
//                 field("Amount"; Rec.Amount)
//                 {
//                     ApplicationArea = All;
//                     Caption = 'Amount';

//                     // trigger OnValidate()
//                     // var
//                     //     LeaseProposalDetails: Record "Lease Proposal Details";
//                     // begin
//                     //     if Rec."Secondary Item Type" = 'Rera Fees' then begin
//                     //         if LeaseProposalDetails.Get(Rec."ProposalID") then begin
//                     //             LeaseProposalDetails.Validate("Rera Fees", Rec.Amount);
//                     //             LeaseProposalDetails.Modify();
//                     //             CurrPage.Update(false);
//                     //         end;
//                     //     end;
//                     // end;

//                 }

//                 field("VAT %"; Rec."VAT %")
//                 {
//                     ApplicationArea = All;
//                     trigger OnValidate()
//                     begin
//                         CurrPage.Update(); // Refresh the page to apply changes immediately
//                     end;

//                 }

//                 field("VAT Amount"; Rec."VAT Amount")
//                 {
//                     ApplicationArea = All;
//                     Caption = 'VAT Amount';
//                 }

//                 field("Amount Including VAT"; Rec."Amount Including VAT")
//                 {
//                     ApplicationArea = All;
//                     Caption = 'Amount Including VAT';
//                 }

//                 field("Start Date"; Rec."Start Date")
//                 {
//                     ApplicationArea = All;
//                     Caption = 'Start Date';
//                     Lookup = true;
//                 }

//                 field("End Date"; Rec."End Date")
//                 {
//                     ApplicationArea = All;
//                     Caption = 'End Date';
//                     Lookup = true;
//                 }

//                 // field("No. of Installments"; Rec."No. of Installments")
//                 // {
//                 //     ApplicationArea = All;
//                 //     Caption = 'No. of Installments';
//                 // }

//                 field("Link"; Rec."Link")
//                 {
//                     ApplicationArea = All;
//                     Editable = false;
//                     DrillDown = true;



//                     trigger OnDrillDown()
//                     var
//                         SubPageID: Integer;
//                         TargetRecord: Record "Lease Proposal Details";
//                         SubgridRecord: Record "Revenue Item Subpage2";
//                         RevenueType: Text[100];
//                         VATPercent: Option;
//                         Amount: Decimal;
//                         VATAmount: Decimal;
//                         TotalAmount: Decimal;
//                         OtherFees: Text[100];


//                     begin
//                         if TargetRecord.Get(Rec."ProposalID") then begin

//                             // if TargetRecord.Get(TargetRecord."Proposal ID") then begin

//                             TargetRecord.SetRange("Proposal ID", Rec."ProposalID");
//                             // SubgridRecord.SetCurrentKey("ProposalID", "Secondary Item Type");
//                             // SubgridRecord.SetRange("Secondary Item Type", Rec."Secondary Item Type");


//                             // if SubgridRecord.FindSet() then begin
//                             SubPageID := Rec."ProposalID";
//                             RevenueType := Rec."Secondary Item Type";
//                             Amount := Rec.Amount;
//                             VATPercent := Rec."VAT %";
//                             VATAmount := Rec."VAT Amount";
//                             TotalAmount := Rec."Amount Including VAT";


//                             // if TargetRecord.Get(Rec."ProposalID") then begin
//                             // Rec."ProposalID" := TargetRecord."Proposal ID";
//                             if TargetRecord.FindSet() then begin

//                                 if RevenueType = 'Rera Fees' then begin
//                                     TargetRecord."Rera Fees" := Amount;
//                                 end
//                                 else if RevenueType = 'Security Deposit Amount' then begin
//                                     TargetRecord."Security Deposit Amount" := Amount;
//                                 end
//                                 else if RevenueType = 'Other Fees' then begin
//                                     TargetRecord."Other Fees" := OtherFees;
//                                 end
//                                 else if RevenueType = 'Chiller Deposit Amount' then begin
//                                     TargetRecord."Chiller Deposit Amount" := Amount;
//                                 end
//                                 else if RevenueType = 'Electricity Deposit Amount' then begin
//                                     TargetRecord."Electricity Deposit Amount" := Amount;
//                                 end
//                                 else if RevenueType = 'Electricity Deposit Amount' then begin
//                                     TargetRecord."Electricity Deposit Amount" := Amount;
//                                 end
//                                 else if RevenueType = 'Ejari Processing Fees' then begin
//                                     TargetRecord."Ejari Processing Fees" := Amount;
//                                     TargetRecord."Ejari Fees VAT %" := VATPercent;
//                                     TargetRecord."Ejari VAT Amount" := VATAmount;
//                                     TargetRecord."Ejari Fees Including VAT" := TotalAmount;
//                                 end
//                                 else if RevenueType = 'Renewal Amount' then begin
//                                     TargetRecord."Renewal Amount" := Amount;
//                                     TargetRecord."Renewal Amount VAT %" := VATPercent;
//                                     TargetRecord."Renewal VAT Amount" := VATAmount;
//                                     TargetRecord."Renewal Amount Including VAT" := TotalAmount;
//                                 end;

//                                 TargetRecord.Modify();
//                                 //CurrPage.Update();

//                             end else begin
//                                 Error('No records found for Proposal ID %1 and Secondary Item Type %2.', Rec."ProposalID", Rec."Secondary Item Type");
//                             end;

//                             Message('Fields updated successfully in Lease Proposal for ProposalID %1 and Proposal ID %2.', Rec."ProposalID", TargetRecord."Proposal ID");

//                             // end;
//                             // end;
//                             // end;

//                         end;

//                     end;



//                 }

//             }
//         }
//     }



//     procedure SetProposalID(pProposalID: Integer)
//     begin
//         proposalID := pProposalID;
//     end;

//     procedure SetStartEndDate(pStartDate: Date; pEndDate: Date)
//     begin
//         startDate := pStartDate;
//         endDate := pEndDate;
//     end;

//     trigger OnInsertRecord(BelowxRec: Boolean): Boolean
//     begin
//         Rec.ProposalID := proposalID;
//         Rec."Start Date" := startDate;
//         Rec."End Date" := endDate;
//     end;

//     var
//         proposalID: Integer;
//         startDate: Date;
//         endDate: Date;








// }


