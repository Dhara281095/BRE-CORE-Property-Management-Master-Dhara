page 50122 "Revenue Allocation Card"
{
    PageType = Card;
    SourceTable = "Revenue Allocation Details";
    ApplicationArea = All;
    Caption = 'Revenue Allocation Details';
    //  UsageCategory = Administration;

    layout
    {
        area(content)
        {
            group(Group)
            {
                Caption = 'Revenue Allocation Details';
                field("No."; Rec."No.")
                {
                    ApplicationArea = All;
                    trigger OnValidate()
                    begin
                        if xRec."No." <> Rec."No." then
                            ClearSubgridData();
                    end;
                }
                field(Month; Rec.Month)
                {
                    ApplicationArea = All;
                }
                field("Financial Year"; Rec."Financial Year")
                {
                    ApplicationArea = All;
                }
                field(Status; Rec.Status)
                {
                    ApplicationArea = All;
                    Editable = false;
                }
            }
            group("Revenue Allocation Report Details")
            {
                Caption = 'Revenue Allocation Report Details';
                part("Revenue Allocation Details"; "Revenue Allocation SubGrid")
                {
                    SubPageLink = "Header No." = field("No.");
                }
            }
            group("Total Calculations")
            {
                Caption = 'Total Calculations';
                field(TotalContractAmount; TotalContractAmount)
                {
                    Caption = 'Total Contract Amount';
                    Editable = false;
                    ApplicationArea = All;
                }
                field(TotalAnnualAmount; TotalAnnualAmount)
                {
                    Caption = 'Total Annual Amount';
                    Editable = false;
                    ApplicationArea = All;
                }
                field(TotalFinalAnnualAmount; TotalFinalAnnualAmount)
                {
                    Caption = 'Total Final Annual Amount';
                    Editable = false;
                    ApplicationArea = All;
                }
                field(TotalValue; TotalValue)
                {
                    Caption = 'Total Value';
                    Editable = false;
                    ApplicationArea = All;
                }
            }

            group("Revenue Recognition Item")
            {
                Caption = 'Revenue Item Details';
                part("Revenue Recognition Item Details"; "Revenue Recognition Item Sub")
                {
                    SubPageLink = "RR_No." = field("No.");
                }
            }

            group("Revenue Recognition Detail")
            {
                Caption = 'Revenue Recognition Details';
                part("Revenue Recognition Details"; "Revenue Recognition Detail Sub")
                {
                    SubPageLink = "RR_No." = field("No.");
                }
            }
            group(" ")
            {
                field("Total Amount"; totalamounts)
                {
                    ApplicationArea = All;
                    Caption = 'Total Amount';
                    Editable = false;
                }
                field("Total Contract Amount"; totalcontractAmounts)
                {
                    ApplicationArea = All;
                    Caption = 'Total Contract Amount';
                    Editable = false;
                }
            }
            group("Final Amount")
            {
                Caption = 'Final Amount';

                field(TotalAnnualAmounts; TotalAnnualAmount)
                {
                    Caption = 'Total Annual Amount';
                    Editable = false;
                    ApplicationArea = All;
                }
                field(TotalFinalAnnualAmounts; TotalFinalAnnualAmount)
                {
                    Caption = 'Total Final Annual Amount';
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Total Amounts"; totalcombineamounts)
                {
                    ApplicationArea = All;
                    Caption = 'Total Amount';
                    Editable = false;
                }
                field("Total Contract Amounts"; totalcombinecontractAmounts)
                {
                    ApplicationArea = All;
                    Caption = 'Total Contract Amount';
                    Editable = false;
                }
            }
        }
    }

    actions
    {
        area(Processing)
        {
            // =================================FilterSubgrid STARTS HERE===================================================
            // Purpose: Filters and processes revenue allocation data for rent calculations
            // This action fetches contract data and calculates totals
            action(FilterSubgrid)
            {
                Caption = 'Revenue Allocation-Rent';
                trigger OnAction()
                begin
                    FetchContracts();
                    CalculateTotals();
                end;
            }
            // =================================FilterSubgrid ENDS HERE===================================================

            // ==============================Process Selected Items STARTS HERE======================================================
            // Purpose: Processes other charges by linking Revenue Item Breakdown to Revenue Recognition Item
            // This action matches items by Item Type and creates necessary links
            action("Process Selected Items")
            {
                Caption = 'Process Other Charges';
                ApplicationArea = All;

                trigger OnAction()
                var
                    SourceRec: Record "Revenue Item Breakdown";
                    TargetRec: Record "Revenue Recognition Item";
                begin
                    // ✅ Set the RR_No. filter BEFORE calling FindSet
                    TargetRec.Reset();
                    TargetRec.SetRange("RR_No.", Rec."No.");

                    if TargetRec.FindSet() then begin
                        repeat
                            // Find matching Revenue Item Breakdown by Item Type
                            SourceRec.Reset();
                            SourceRec.SetRange("Item Type", TargetRec."Item Type");

                            if SourceRec.FindFirst() then begin
                                TargetRec.Link := SourceRec."RI_No.";
                                TargetRec."RR_No." := Rec."No."; // Set header ID
                                TargetRec.Modify(true); // Save changes and keep record visible
                            end;
                        until TargetRec.Next() = 0;

                        Message('Selected records processed successfully.');
                    end else
                        Message('No selected records found.');
                end;
            }
            // ==============================Process Selected Items ENDS HERE======================================================

            // ================================RevenueAllocation STARTS HERE======================================================
            // Purpose: Sends or modifies revenue allocation approval requests
            // This action creates approval workflow entries for the current revenue allocation
            action(RevenueAllocation)
            {
                ApplicationArea = All;
                Caption = 'Revenue Allocation Approval';
                Image = PostDocument;
                Enabled = Rec.Status = Rec.Status::Pending;

                trigger OnAction()
                var
                    Approvalrevenueallocation: Record "Revenue Allocation Approval";
                    revenueallocation: Record "Revenue Allocation Details";
                begin
                    // Validate required fields
                    if Rec."No." = 0 then
                        Error('No must be specified');

                    Approvalrevenueallocation.SetRange("ID", Rec."No.");

                    if Approvalrevenueallocation.FindSet() then begin
                        // Modify existing approval record
                        Approvalrevenueallocation."ID" := Rec."No.";
                        Approvalrevenueallocation."Month" := Rec."Month";
                        Approvalrevenueallocation."Financial Year" := Rec."Financial Year";
                        Approvalrevenueallocation."Status" := Rec."Status";
                        Approvalrevenueallocation.Modify();
                        Message('Approval Request Modified successfully!');
                    end else begin
                        // Insert new approval record
                        Approvalrevenueallocation.Init();
                        Approvalrevenueallocation."ID" := Rec."No.";
                        Approvalrevenueallocation."Financial Year" := Rec."Financial Year";
                        Approvalrevenueallocation."Month" := Rec."Month";
                        Approvalrevenueallocation."Status" := Rec."Status";
                        Approvalrevenueallocation.Insert();
                        Message('Approval Request Sent successfully!');
                    end;
                end;
            }
            // ================================RevenueAllocation ENDS HERE======================================================
        }
    }

    // ================================OnNewRecord STARTS HERE====================================================
    // Purpose: Executes when a new record is created
    // Clears subgrid data to ensure clean state for new records
    trigger OnNewRecord(BelowxRec: Boolean)
    begin
        ClearSubgridData();
    end;
    // ================================OnNewRecord ENDS HERE====================================================

    // ============================OnAfterGetRecord STARTS HERE========================================================
    // Purpose: Executes after a record is retrieved and displayed
    // Calculates totals and sets up subpage connections
    trigger OnAfterGetRecord()
    begin
        CalculateTotals();
        CurrPage."Revenue Recognition Item Details".Page.SetRIID(Rec."No.");
        CurrPage."Revenue Recognition Details".Page.SetRIID(Rec."No.");
    end;
    // ============================OnAfterGetRecord ENDS HERE========================================================


    // ========================GLOBAL VARIABLES SECTION STARTS HERE============================================================
    // These variables store calculated totals that are displayed in the page fields
    var
        TotalContractAmount: Decimal;
        TotalAnnualAmount: Decimal;
        TotalFinalAnnualAmount: Decimal;
        TotalValue: Decimal;
    // ========================GLOBAL VARIABLES SECTION ENDS HERE============================================================

    // ================================CalculateTotals STARTS HERE====================================================
    // Purpose: Calculates and updates all total amounts displayed on the page
    // This procedure sums up amounts from Revenue Allocation SubGrid while excluding
    // suspended contracts during the selected month
    procedure CalculateTotals()
    var
        FilteredContractRec: Record "Revenue Allocation SubGrid";
        SuspensionRec: Record SuspendReasonTable;
        SelectedMonthStart: Date;
        SelectedMonthEnd: Date;
    begin
        // Reset all totals to zero before calculation
        TotalContractAmount := 0;
        TotalAnnualAmount := 0;
        TotalFinalAnnualAmount := 0;
        TotalValue := 0;

        // Calculate first and last day of selected month for suspension checking
        SelectedMonthStart := DMY2Date(1, Rec.Month, Rec."Financial Year");
        SelectedMonthEnd := CALCDATE('<CM>', SelectedMonthStart);

        // Filter records to only include items belonging to current revenue allocation header
        FilteredContractRec.Reset();
        FilteredContractRec.SetRange("Header No.", Rec."No.");

        // Loop through all allocation line items and sum up amounts
        if FilteredContractRec.FindSet() then begin
            repeat
                // Check if the contract is suspended during the selected month
                // This prevents including suspended contracts in total calculations
                SuspensionRec.Reset();
                SuspensionRec.SetRange("Contract ID", FilteredContractRec."Contract Id");
                SuspensionRec.SetFilter(DateEffective, '..%1', SelectedMonthEnd); // Suspension started before or on month end
                SuspensionRec.SetFilter(SuspensionEndDate, '%1..', SelectedMonthStart);// Suspension ended on or after month start

                // Only add to totals if the contract is NOT suspended during the selected month
                if not SuspensionRec.FindFirst() then begin
                    TotalContractAmount += FilteredContractRec."Contract Amount";
                    TotalAnnualAmount += FilteredContractRec."Annual Amount";
                    TotalFinalAnnualAmount += FilteredContractRec."Final Annual Amount";
                    TotalValue += FilteredContractRec."Total Value";
                end;
            until FilteredContractRec.Next() = 0;
        end;
        CurrPage.Update(false);  // Refresh page to display updated totals
    end;
    // ================================CalculateTotals ENDS HERE====================================================

    // ============================CalculateDaysInSelectedMonth STARTS HERE========================================================
    // Purpose: Calculates the number of days a contract is active within a specific month
    // This procedure considers contract dates, multi-year period dates, and selected month
    // to determine the exact number of billable days
    //---------------Calculate Days In SelectedMonth--------------//
    procedure CalculateDaysInSelectedMonth(
        ContractStartDate: Date;
        ContractEndDate: Date;
        MultiYearStartDate: Date;
        MultiYearEndDate: Date;
        SelectedMonth: Integer;
        SelectedYear: Integer): Integer
    var
        StartDate: Date;
        EndDate: Date;
        MonthStartDate: Date;
        MonthEndDate: Date;
        EffectiveStartDate: Date;
        EffectiveEndDate: Date;
    begin
        // Get first day of selected month
        MonthStartDate := DMY2Date(1, SelectedMonth, SelectedYear);
        // Get last day of selected month
        MonthEndDate := CALCDATE('<+1M-1D>', MonthStartDate);

        // Return 0 if multi-year period is completely outside selected month
        // This happens when the period ends before the month starts or starts after the month ends
        if (MultiYearStartDate > MonthEndDate) or (MultiYearEndDate < MonthStartDate) then
            exit(0);

        // Determine effective start date for the month
        // Use the latest of: MonthStart, MultiYearStart, ContractStart // This ensures we only count days when all conditions are met
        EffectiveStartDate := MonthStartDate;
        if MultiYearStartDate > EffectiveStartDate then
            EffectiveStartDate := MultiYearStartDate;
        if ContractStartDate > EffectiveStartDate then
            EffectiveStartDate := ContractStartDate;

        // Determine effective end date for the month  
        // Use the earliest of: MonthEnd, MultiYearEnd, ContractEnd // This ensures we don't count days beyond any limiting date
        EffectiveEndDate := MonthEndDate;
        if MultiYearEndDate < EffectiveEndDate then
            EffectiveEndDate := MultiYearEndDate;
        if ContractEndDate < EffectiveEndDate then
            EffectiveEndDate := ContractEndDate;

        // Ensure we don't have invalid date range
        if EffectiveStartDate > EffectiveEndDate then
            exit(0);

        // Calculate inclusive number of days
        exit(EffectiveEndDate - EffectiveStartDate + 1);
    end;
    // ============================CalculateDaysInSelectedMonth ENDS HERE========================================================

    // ===============================ClearSubgridData STARTS HERE=====================================================
    // Purpose: Clears all related subgrid data when switching records or creating new ones
    // This ensures data consistency and prevents mixing data from different records
    procedure ClearSubgridData()
    var
        FilteredContractRec: Record "Revenue Allocation SubGrid";
        revenueitem: Record "Revenue Recognition Item";
    begin
        FilteredContractRec.Reset();
        FilteredContractRec.SetRange("Header No.", Rec."No.");
        FilteredContractRec.DeleteAll();
        revenueitem.Reset();
        revenueitem.SetRange("RR_No.", Rec."No.");
        revenueitem.DeleteAll();
    end;
    // ===============================ClearSubgridData ENDS HERE=====================================================

    // ================================GetNextLineNo STARTS HERE====================================================
    // Purpose: Generates the next available line number for new subgrid entries
    // This ensures unique line numbers and proper sequencing of records
    //---------------Get Next LineNo--------------//
    procedure GetNextLineNo(): Integer
    var
        FilteredContractRec: Record "Revenue Allocation SubGrid";
        LastLineNo: Integer;
    begin
        FilteredContractRec.Reset();
        FilteredContractRec.SetRange("Header No.", Rec."No.");
        if FilteredContractRec.FindLast() then
            LastLineNo := FilteredContractRec."Line No."
        else
            LastLineNo := 0;
        exit(LastLineNo + 1);
    end;
    // ================================GetNextLineNo ENDS HERE====================================================

    // ===============================ShouldKeepEntry STARTS HERE=====================================================
    // Purpose: Determines if a date range overlaps with the selected month
    // This is used to filter entries that are relevant to the current month
    //---------------Should Keep Entry--------------//
    procedure ShouldKeepEntry(StartDate: Date; EndDate: Date): Boolean
    var
        CheckDate: Date;
        LastDayOfMonth: Date;
        FirstDayOfMonth: Date;
    begin
        // Get first day of selected month
        FirstDayOfMonth := DMY2Date(1, Rec.Month, Rec."Financial Year");

        // Get last day of selected month
        LastDayOfMonth := CALCDATE('<+1M-1D>', FirstDayOfMonth);

        // Check if selected month's date range overlaps with the given date range
        // A period overlaps if:
        if (StartDate <= LastDayOfMonth) and (EndDate >= FirstDayOfMonth) then
            exit(true);

        exit(false);
    end;
    // ===============================ShouldKeepEntry ENDS HERE=====================================================

    // =============================InsertAllocationLine STARTS HERE=======================================================
    // Purpose: Inserts revenue allocation line items into the subgrid
    // This procedure handles complex logic for:
    // 1. Creating main allocation lines with calculated amounts
    // 2. Creating grace period adjustment lines (negative amounts)
    // 3. Handling suspension checks and date validations
    // 4. Calculating per-day rent with and without grace periods
    //---------------Insert Allocation Line--------------//
    procedure InsertAllocationLine(
     ContractRec: Record "Tenancy Contract";
     MultiYearStartDate: Date;
     MultiYearEndDate: Date;
     NoOfDays: Integer;
     PerDayRent: Decimal;
     TotalAnnualAmount: Decimal;
     OwnerShareAmount: Decimal;
     TerminationDate: Date;
     LineNo: Integer;
     MonthNo: Integer;
     FinancialYear: Integer)
    var
        FilteredContractRec: Record "Revenue Allocation SubGrid";
        SuspensionRec: Record SuspendReasonTable;
        CalculatedDays: Integer;
        NewLineNo: Integer;
        PerDayRentWithoutGracePeriod: Decimal;
        PerDayRentWithGracePeriod: Decimal;
        TotalContractDays: Integer;
        TotalContractDaysWithGrace: Integer;
        DifferencePerDayRent: Decimal;
        GracePeriodAdjustmentValue: Decimal;
        GridAnnualAmount: Decimal;
        // New variables for grace period date check
        GraceStartDate: Date;
        GraceEndDate: Date;
        SelectedMonthStart: Date;
        SelectedMonthEnd: Date;
        ShouldInsertGraceLine: Boolean;
    begin
        // Check if entry should be kept based on date range overlap with selected month
        if not ShouldKeepEntry(MultiYearStartDate, MultiYearEndDate) then
            exit;

        // Calculate selected month date range for grace period validation
        SelectedMonthStart := DMY2Date(1, MonthNo, FinancialYear);
        SelectedMonthEnd := CALCDATE('<+1M-1D>', SelectedMonthStart);

        // Calculate grace period dates from contract
        GraceStartDate := ContractRec."Grace Start Date";
        GraceEndDate := ContractRec."Grace End Date";

        // Determine if grace period adjustment line should be created
        // Grace period should be inserted only if:
        // 1. Contract has grace period > 0
        // 2. Grace start and end dates are defined
        // 3. Grace period overlaps with selected month
        ShouldInsertGraceLine := (ContractRec."Grace Period" > 0) and
                                (GraceStartDate <> 0D) and (GraceEndDate <> 0D) and
                                (GraceStartDate <= SelectedMonthEnd) and
                                (GraceEndDate >= SelectedMonthStart);

        // Generate new line number for the allocation line
        NewLineNo := GetNextLineNo();

        // Calculate the actual number of days for the selected month
        // This considers contract dates, multi-year dates, and month boundaries
        CalculatedDays := CalculateDaysInSelectedMonth(
            ContractRec."Contract Start Date",
            ContractRec."Contract End Date",
            MultiYearStartDate,
            MultiYearEndDate,
            MonthNo,
            FinancialYear
        );

        // Calculate total days in the multi-year period
        TotalContractDays := MultiYearEndDate - MultiYearStartDate + 1;

        // Calculate total days including grace period
        TotalContractDaysWithGrace := TotalContractDays + ContractRec."Grace Period";

        // Use the annual amount from the grid record instead of the main contract
        GridAnnualAmount := TotalAnnualAmount;

        // Calculate per day rent without grace period consideration
        PerDayRentWithoutGracePeriod := Round(GridAnnualAmount / TotalContractDays);

        // Calculate per day rent with grace period consideration (lower amount)
        PerDayRentWithGracePeriod := Round(GridAnnualAmount / TotalContractDaysWithGrace);

        // Calculate the difference per day (amount to be adjusted)
        DifferencePerDayRent := PerDayRentWithoutGracePeriod - PerDayRentWithGracePeriod;

        // Calculate total adjustment value for the selected month
        GracePeriodAdjustmentValue := DifferencePerDayRent * CalculatedDays;

        // -----------------------------------------------
        // INSERT MAIN ALLOCATION LINE STARTS HERE
        // -----------------------------------------------
        // Create the primary allocation line (without grace period adjustment)
        FilteredContractRec.Init();
        FilteredContractRec."Line No." := NewLineNo;
        FilteredContractRec."Header No." := Rec."No.";
        FilteredContractRec."Property Name" := ContractRec."Property Name";
        FilteredContractRec."Contract Id" := ContractRec."Contract ID";
        FilteredContractRec."Contract Tenure" := ContractRec."Contract Tenor";
        FilteredContractRec."Customer Name" := ContractRec."Customer Name";
        FilteredContractRec."Contract Start Date" := ContractRec."Contract Start Date";
        FilteredContractRec."Contract End Date" := ContractRec."Contract End Date";
        FilteredContractRec."Grace Days" := ContractRec."Grace Period";
        FilteredContractRec."Grace Start Date" := ContractRec."Grace Start Date";
        FilteredContractRec."Grace End Date" := ContractRec."Grace End Date";

        // Set termination date if provided
        if TerminationDate = 0D then
            FilteredContractRec."Termination Date" := 0D
        else
            FilteredContractRec."Termination Date" := TerminationDate;

        // Check for suspension information and populate if found
        SuspensionRec.Reset();
        SuspensionRec.SetRange("Contract ID", ContractRec."Contract ID");
        if SuspensionRec.FindFirst() then begin
            FilteredContractRec."Suspension Start Date" := SuspensionRec.DateEffective;
            FilteredContractRec."Suspension End Date" := SuspensionRec.SuspensionEndDate;
        end;

        // Set calculated values for the allocation line
        FilteredContractRec."Multi Year Start Date" := MultiYearStartDate;
        FilteredContractRec."Multi Year End Date" := MultiYearEndDate;
        FilteredContractRec."No Of Days" := CalculatedDays;
        FilteredContractRec."Per Day Rent" := Round(PerDayRent); // Use the per day rent passed from the grid
        FilteredContractRec."Contract Amount" := ContractRec."Annual Rent Amount"; // Use grid's annual amount
        FilteredContractRec."Annual Amount" := GridAnnualAmount;
        FilteredContractRec."Total Value" := CalculatedDays * FilteredContractRec."Per Day Rent";
        FilteredContractRec."Owner Share" := CalculatedDays * FilteredContractRec."Per Day Rent";
        FilteredContractRec."Final Annual Amount" := TotalAnnualAmount;
        FilteredContractRec."Posting Month" := MonthNo;
        FilteredContractRec."Posting Year" := FinancialYear;
        FilteredContractRec."Posting Period" := Format(FilteredContractRec."Posting Month") +
            ' ' + Format(FilteredContractRec."Posting Year") + ' ' + '-' + ' ' +
            Format(FilteredContractRec."Posting Month") + ' ' + Format(FilteredContractRec."Posting Year");
        FilteredContractRec."Owner Name" := ContractRec."Owner's Name";
        FilteredContractRec.Insert();
        // INSERT MAIN ALLOCATION LINE ENDS HERE

        // -----------------------------------------------
        // INSERT GRACE PERIOD ADJUSTMENT LINE STARTS HERE
        // -----------------------------------------------
        // Create grace period adjustment line (negative allocation) if conditions are met
        // Only insert if grace period dates fall within selected month
        if ShouldInsertGraceLine then begin
            NewLineNo := GetNextLineNo();  // Get new line number for grace adjustment

            FilteredContractRec.Init();
            FilteredContractRec."Line No." := NewLineNo;
            FilteredContractRec."Header No." := Rec."No.";
            FilteredContractRec."Property Name" := ContractRec."Property Name";
            FilteredContractRec."Contract Id" := ContractRec."Contract ID";
            FilteredContractRec."Contract Tenure" := ContractRec."Contract Tenor";
            FilteredContractRec."Customer Name" := ContractRec."Customer Name";
            FilteredContractRec."Contract Start Date" := ContractRec."Contract Start Date";
            FilteredContractRec."Contract End Date" := ContractRec."Contract End Date";
            FilteredContractRec."Grace Days" := ContractRec."Grace Period";
            FilteredContractRec."Grace Start Date" := ContractRec."Grace Start Date";
            FilteredContractRec."Grace End Date" := ContractRec."Grace End Date";

            // Set termination date if provided
            if TerminationDate = 0D then
                FilteredContractRec."Termination Date" := 0D
            else
                FilteredContractRec."Termination Date" := TerminationDate;

            // Populate suspension information if found
            if SuspensionRec.FindFirst() then begin
                FilteredContractRec."Suspension Start Date" := SuspensionRec.DateEffective;
                FilteredContractRec."Suspension End Date" := SuspensionRec.SuspensionEndDate;
            end;

            // Set calculated values for the grace period adjustment line
            FilteredContractRec."Multi Year Start Date" := MultiYearStartDate;
            FilteredContractRec."Multi Year End Date" := MultiYearEndDate;
            FilteredContractRec."No Of Days" := CalculatedDays;
            FilteredContractRec."Per Day Rent" := -DifferencePerDayRent; // Negative value for adjustment
            FilteredContractRec."Contract Amount" := ContractRec."Annual Rent Amount"; // Use grid's annual amount
            FilteredContractRec."Annual Amount" := GridAnnualAmount;
            FilteredContractRec."Total Value" := -GracePeriodAdjustmentValue; // Negative adjustment amount
            FilteredContractRec."Owner Share" := -GracePeriodAdjustmentValue; // Negative adjustment amount
            FilteredContractRec."Final Annual Amount" := TotalAnnualAmount;
            FilteredContractRec."Posting Month" := MonthNo;
            FilteredContractRec."Posting Year" := FinancialYear;
            FilteredContractRec."Posting Period" := Format(FilteredContractRec."Posting Month") +
                ' ' + Format(FilteredContractRec."Posting Year") + ' ' + '-' + ' ' +
                Format(FilteredContractRec."Posting Month") + ' ' + Format(FilteredContractRec."Posting Year");
            FilteredContractRec."Owner Name" := ContractRec."Owner's Name";
            // Optional: Add description to identify this as grace period adjustment
            // FilteredContractRec."Description" := 'Grace Period Adjustment';
            FilteredContractRec.Insert();
        end;
        // INSERT GRACE PERIOD ADJUSTMENT LINE ENDS HERE
    end;
    // =============================InsertAllocationLine STARTS HERE=======================================================



    // ========================HandleMissedAllocation - STARTS HERE==========================================
    // PURPOSE: This procedure handles missed revenue allocations for contracts 
    //          that started in the previous month but weren't processed at that time.
    //          It calculates and allocates rent for the missed days from contract 
    //          start date to the end of the previous month.
    // 
    // WHEN USED: Called when processing current month revenue allocation and 
    //            detecting that a contract started in the previous month
    // 
    // LOGIC: 1. Determines if contract started in previous month
    //        2. Calculates missed days from contract start to previous month end
    //        4. Creates allocation entries for each applicable rent record
    // ==================================================================
    procedure HandleMissedAllocation(
     ContractRec: Record "Tenancy Contract";
     MonthNo: Integer;
     FinancialYear: Integer)
    var
        // Variables for calculating previous month and year
        PreviousMonthNo: Integer;
        PreviousYearNo: Integer;

        // Date range variables for calculations
        PreviousMonthStart: Date;     // First day of previous month
        PreviousMonthEnd: Date;       // Last day of previous month
        CurrentMonthStart: Date;      // First day of current month
        CurrentMonthEnd: Date;       // Last day of current month
        ContractStartDate: Date;     // Date when contract started

        // Calculation variables
        MissedDays: Integer;         // Number of days missed in previous month
        LineNo: Integer;             // Line number for allocation entries
        TerminationDate: Date;       // Contract termination date if applicable

        // Record variables for different rent types
        SingleUnitRent: Record "TC Single Unit Rent SubPage";
        MultiUnitRent: Record "TC Single LumAnnualAmnt SP";
        MergedSingleRent: Record "TC Merge SameSqure SubPage";
        MergedMultiRent: Record "TC Merge DifferentSq SubPage";
        SpecialRent: Record "TC Merge LumAnnualAmount SP";
        FinalCalculationRec: Record "Final Calculation";

    begin
        // =========================CALCULATE PREVIOUS MONTH AND YEAR - STARTS HERE=========================================
        // STEP 1:==================================================================
        // PURPOSE: Determine the previous month and year for missed allocation calculation
        // LOGIC: If current month is January (1), previous month is December (12) of previous year
        //        Otherwise, previous month is current month - 1 of same year
        // =========================================================================
        if MonthNo = 1 then begin
            // Current month is January, so previous month is December of previous year
            PreviousMonthNo := 12;
            PreviousYearNo := FinancialYear - 1;
        end else begin
            // Current month is not January, so previous month is current month - 1
            PreviousMonthNo := MonthNo - 1;
            PreviousYearNo := FinancialYear;
        end;
        // =========================CALCULATE PREVIOUS MONTH AND YEAR - ENDS HERE=========================================


        // ============================CALCULATE DATE RANGES - STARTS HERE======================================
        // STEP 2:==================================================================
        // PURPOSE: Calculate start and end dates for previous month and current month
        // LOGIC: Use DMY2Date to create dates and CALCDATE to find month end
        // =========================================================================

        // Create first day of previous month
        PreviousMonthStart := DMY2Date(1, PreviousMonthNo, PreviousYearNo);
        // Calculate last day of previous month using '<CM>' (Current Month end)
        PreviousMonthEnd := CALCDATE('<CM>', PreviousMonthStart);
        // Create first day of current month
        CurrentMonthStart := DMY2Date(1, MonthNo, FinancialYear);
        // Calculate last day of current month
        CurrentMonthEnd := CALCDATE('<CM>', CurrentMonthStart);
        // Get contract start date from contract record
        ContractStartDate := ContractRec."Contract Start Date";
        // ============================CALCULATE DATE RANGES - ENDS HERE======================================

        // ==========================CHECK IF CONTRACT STARTED IN PREVIOUS MONTH - STARTS HERE========================================
        // STEP 3:==================================================================
        // PURPOSE: Determine if this contract started in the previous month and needs missed allocation
        // LOGIC: Contract start date must be between previous month start and end dates
        // =========================================================================
        // Check if contract started in previous month
        if (ContractStartDate >= PreviousMonthStart) and (ContractStartDate <= PreviousMonthEnd) then begin
            // PURPOSE: Calculate how many days were missed in the previous month
            // LOGIC: From contract start date to end of previous month (inclusive)
            MissedDays := PreviousMonthEnd - ContractStartDate + 1;
            // PURPOSE: Get contract termination date from Final Calculation table
            // LOGIC: Search for contract in Final Calculation table and get termination date
            //        If not found, set to empty date (0D)
            FinalCalculationRec.Reset();
            FinalCalculationRec.SetRange("Contract ID", ContractRec."Contract ID");
            if FinalCalculationRec.FindFirst() then
                TerminationDate := FinalCalculationRec."Termination Date"
            else
                TerminationDate := 0D;

            // PURPOSE: Process missed allocation for Single Unit Rent records
            // LOGIC: Find all Single Unit Rent records for this contract
            //        Check if each record's date range overlaps with missed period
            //        Create allocation entries for overlapping records
            SingleUnitRent.Reset();
            SingleUnitRent.SetRange("Contract ID", ContractRec."Contract ID");
            if SingleUnitRent.FindSet() then begin
                repeat
                    // Check if this rent record overlaps with the missed period
                    // Record start date must be <= previous month end AND
                    // Record end date must be >= contract start date
                    if (SingleUnitRent."Start Date" <= PreviousMonthEnd) and (SingleUnitRent."End Date" >= ContractStartDate) then begin
                        // Create missed allocation entry for this Single Unit Rent record
                        InsertMissedAllocationLine(
                            ContractRec,
                            SingleUnitRent."Start Date",
                            SingleUnitRent."End Date",
                            SingleUnitRent."Number of Days",
                            SingleUnitRent."Per Day Rent",
                            SingleUnitRent."Final Annual Amount",
                            SingleUnitRent."Final Annual Amount",
                            TerminationDate,
                            LineNo,
                            PreviousMonthNo,
                            PreviousYearNo,
                            ContractStartDate,
                            PreviousMonthEnd);
                    end;
                until SingleUnitRent.Next() = 0;
            end;


            // PURPOSE: Process missed allocation for Multi Unit Rent records
            // LOGIC: Same as Single Unit Rent but uses Multi Unit Rent table
            //        Uses "SL_" prefixed field names (SL = Single Lump?)
            MultiUnitRent.Reset();
            MultiUnitRent.SetRange("Contract ID", ContractRec."Contract ID");
            if MultiUnitRent.FindSet() then begin
                repeat
                    // Check if this rent record overlaps with the missed period
                    if (MultiUnitRent."SL_Start Date" <= PreviousMonthEnd) and (MultiUnitRent."SL_End Date" >= ContractStartDate) then begin
                        // Create missed allocation entry for this Multi Unit Rent record
                        InsertMissedAllocationLine(
                            ContractRec,
                            MultiUnitRent."SL_Start Date",
                            MultiUnitRent."SL_End Date",
                            MultiUnitRent."SL_Number of Days",
                            MultiUnitRent."SL_Per Day Rent",
                            MultiUnitRent."SL_Final Annual Amount",
                            MultiUnitRent."SL_Final Annual Amount",
                            TerminationDate,
                            LineNo,
                            PreviousMonthNo,
                            PreviousYearNo,
                            ContractStartDate,
                            PreviousMonthEnd);
                    end;
                until MultiUnitRent.Next() = 0;
            end;


            // PURPOSE: Process missed allocation for Merged Single Rent records
            // LOGIC: Same logic as previous rent types but for merged single rent
            //        Uses "MS_" prefixed field names (MS = Merged Single?)
            MergedSingleRent.Reset();
            MergedSingleRent.SetRange("Contract ID", ContractRec."Contract ID");
            if MergedSingleRent.FindSet() then begin
                repeat
                    // Check if this rent record overlaps with the missed period
                    if (MergedSingleRent."MS_Start Date" <= PreviousMonthEnd) and (MergedSingleRent."MS_End Date" >= ContractStartDate) then begin
                        // Create missed allocation entry for this Merged Single Rent record
                        InsertMissedAllocationLine(
                            ContractRec,
                            MergedSingleRent."MS_Start Date",
                            MergedSingleRent."MS_End Date",
                            MergedSingleRent."MS_Number of Days",
                            MergedSingleRent."MS_Per Day Rent",
                            MergedSingleRent."MS_Final Annual Amount",
                            MergedSingleRent."MS_Final Annual Amount",
                            TerminationDate,
                            LineNo,
                            PreviousMonthNo,
                            PreviousYearNo,
                            ContractStartDate,
                            PreviousMonthEnd);
                    end;
                until MergedSingleRent.Next() = 0;
            end;


            // PURPOSE: Process missed allocation for Merged Multi Rent records
            // LOGIC: Same logic as previous rent types but for merged multi rent
            //        Uses "MD_" prefixed field names (MD = Merged Different?)
            // Reset and filter Merged Multi Rent records by Contract ID
            MergedMultiRent.Reset();
            MergedMultiRent.SetRange("Contract ID", ContractRec."Contract ID");
            if MergedMultiRent.FindSet() then begin
                repeat
                    // Check if this rent record overlaps with the missed period
                    if (MergedMultiRent."MD_Start Date" <= PreviousMonthEnd) and (MergedMultiRent."MD_End Date" >= ContractStartDate) then begin
                        // Create missed allocation entry for this Merged Multi Rent record
                        InsertMissedAllocationLine(
                            ContractRec,
                            MergedMultiRent."MD_Start Date",
                            MergedMultiRent."MD_End Date",
                            MergedMultiRent."MD_Number of Days",
                            MergedMultiRent."MD_Per Day Rent",
                            MergedMultiRent."MD_Final Annual Amount",
                            MergedMultiRent."MD_Final Annual Amount",
                            TerminationDate,
                            LineNo,
                            PreviousMonthNo,
                            PreviousYearNo,
                            ContractStartDate,
                            PreviousMonthEnd);
                    end;
                until MergedMultiRent.Next() = 0;
            end;


            // PURPOSE: Process missed allocation for Special Rent records
            // LOGIC: Same logic as previous rent types but for special rent
            //        Uses "ML_" prefixed field names (ML = Merged Lump?)
            // Reset and filter Special Rent records by Contract ID
            SpecialRent.Reset();
            SpecialRent.SetRange("Contract ID", ContractRec."Contract ID");
            if SpecialRent.FindSet() then begin
                repeat
                    // Check if this rent record overlaps with the missed period
                    if (SpecialRent."ML_Start Date" <= PreviousMonthEnd) and (SpecialRent."ML_End Date" >= ContractStartDate) then begin
                        // Create missed allocation entry for this Special Rent record
                        InsertMissedAllocationLine(
                            ContractRec,
                            SpecialRent."ML_Start Date",
                            SpecialRent."ML_End Date",
                            SpecialRent."ML_Number of Days",
                            SpecialRent."ML_Per Day Rent",
                            SpecialRent."ML_Final Annual Amount",
                            SpecialRent."ML_Final Annual Amount",
                            TerminationDate,
                            LineNo,
                            PreviousMonthNo,
                            PreviousYearNo,
                            ContractStartDate,
                            PreviousMonthEnd);
                    end;
                until SpecialRent.Next() = 0;
            end;
        end;
    end;
    // ==========================CHECK IF CONTRACT STARTED IN PREVIOUS MONTH - ENDS HERE========================================

    // =========================InsertMissedAllocationLine - STARTS HERE=========================================
    // PURPOSE: Creates actual allocation entries for missed revenue from previous month
    //          This procedure is called by HandleMissedAllocation for each rent record
    //          that needs missed allocation processing
    // 
    // WHEN USED: Called when a rent record overlaps with the missed allocation period
    //            (contract start date to previous month end)
    // 
    // LOGIC: 1. Calculates missed days and gets new line number
    //        2. Calculates grace period adjustments (with and without grace period)
    //        3. Inserts main allocation line with regular rent
    //        4. Inserts grace period adjustment line (negative) if applicable
    // 
    // GRACE PERIOD LOGIC: Grace period reduces daily rent by spreading annual amount
    //                     over more days (contract days + grace days)
    //                     Adjustment = difference between regular and grace period rates
    procedure InsertMissedAllocationLine(
     ContractRec: Record "Tenancy Contract";
     MultiYearStartDate: Date;
     MultiYearEndDate: Date;
     NoOfDays: Integer;
     PerDayRent: Decimal;
     TotalAnnualAmount: Decimal;
     OwnerShareAmount: Decimal;
     TerminationDate: Date;
     LineNo: Integer;
     PreviousMonthNo: Integer;
     PreviousYearNo: Integer;
     ContractStartDate: Date;
     PreviousMonthEnd: Date)
    var
        // Record variables
        FilteredContractRec: Record "Revenue Allocation SubGrid";
        SuspensionRec: Record SuspendReasonTable;
        // Calculation variables
        CalculatedDays: Integer;                          // Days calculated for allocation
        NewLineNo: Integer;                               // Next available line number
        MissedDays: Integer;                              // Number of missed days to allocate
        TotalContractDays: Integer;                       // Total days in contract period
        TotalContractDaysWithGrace: Integer;              // Total days including grace period
        GridAnnualAmount: Decimal;                        // Annual amount from grid record
        // Grace period calculation variables
        PerDayRentWithoutGracePeriod: Decimal;           // Daily rent without grace period
        PerDayRentWithGracePeriod: Decimal;              // Daily rent with grace period
        DifferencePerDayRent: Decimal;                   // Difference between the two rates
        GracePeriodAdjustmentValue: Decimal;             // Total adjustment for missed days
        GraceStartDate: Date;                            // Grace period start date
        GraceEndDate: Date;                              // Grace period end date
        ShouldInsertGraceLine: Boolean;                  // Flag to determine if grace line needed
        // Utility variables
        FetchMonth: Codeunit "Fetch Month";              // Codeunit for month name formatting
    begin
        // Calculate missed days: from contract start to previous month end (inclusive)
        MissedDays := PreviousMonthEnd - ContractStartDate + 1;

        // Get next available line number for allocation entry
        NewLineNo := GetNextLineNo();

        // Use the annual amount from the grid record (not main contract)
        GridAnnualAmount := TotalAnnualAmount;

        // Calculate total days in the rent period (without grace period)
        TotalContractDays := MultiYearEndDate - MultiYearStartDate + 1;

        // Calculate total days including grace period
        TotalContractDaysWithGrace := TotalContractDays + ContractRec."Grace Period";

        // Calculate daily rent without grace period (annual amount ÷ contract days)
        PerDayRentWithoutGracePeriod := Round(GridAnnualAmount / TotalContractDays);

        // Calculate daily rent with grace period (annual amount ÷ (contract days + grace days))
        PerDayRentWithGracePeriod := Round(GridAnnualAmount / TotalContractDaysWithGrace);

        // Calculate the difference per day (this will be the adjustment amount)
        DifferencePerDayRent := PerDayRentWithoutGracePeriod - PerDayRentWithGracePeriod;

        // Calculate total adjustment value for all missed days
        GracePeriodAdjustmentValue := DifferencePerDayRent * MissedDays;

        // Get grace period dates from contract
        GraceStartDate := ContractRec."Grace Start Date";
        GraceEndDate := ContractRec."Grace End Date";

        // Check if grace period should be applied to missed allocation:
        // 1. Grace period exists (> 0 days)
        // 2. Grace dates are valid (not empty)
        // 3. Grace period overlaps with missed allocation period
        ShouldInsertGraceLine := (ContractRec."Grace Period" > 0) and
                                (GraceStartDate <> 0D) and (GraceEndDate <> 0D) and
                                (GraceStartDate <= PreviousMonthEnd) and
                                (GraceEndDate >= ContractStartDate);

        // -----------------------------------------------
        // Insert missed allocation line (without grace period adjustment)
        // -----------------------------------------------
        FilteredContractRec.Init();
        FilteredContractRec."Line No." := NewLineNo;
        FilteredContractRec."Header No." := Rec."No.";
        FilteredContractRec."Property Name" := ContractRec."Property Name";
        FilteredContractRec."Contract Id" := ContractRec."Contract ID";
        FilteredContractRec."Contract Tenure" := ContractRec."Contract Tenor";
        FilteredContractRec."Customer Name" := ContractRec."Customer Name";
        FilteredContractRec."Contract Start Date" := ContractRec."Contract Start Date";
        FilteredContractRec."Contract End Date" := ContractRec."Contract End Date";
        FilteredContractRec."Grace Days" := ContractRec."Grace Period";
        FilteredContractRec."Grace Start Date" := ContractRec."Grace Start Date";
        FilteredContractRec."Grace End Date" := ContractRec."Grace End Date";

        // Add Termination Date
        if TerminationDate = 0D then
            FilteredContractRec."Termination Date" := 0D
        else
            FilteredContractRec."Termination Date" := TerminationDate;

        SuspensionRec.Reset();
        SuspensionRec.SetRange("Contract ID", ContractRec."Contract ID");
        if SuspensionRec.FindFirst() then begin
            FilteredContractRec."Suspension Start Date" := SuspensionRec.DateEffective;
            FilteredContractRec."Suspension End Date" := SuspensionRec.SuspensionEndDate;
        end;

        // Set rent period information
        FilteredContractRec."Multi Year Start Date" := MultiYearStartDate;
        FilteredContractRec."Multi Year End Date" := MultiYearEndDate;
        FilteredContractRec."No Of Days" := MissedDays;
        FilteredContractRec."Per Day Rent" := Round(PerDayRent);
        FilteredContractRec."Contract Amount" := ContractRec."Annual Rent Amount"; // Use grid's annual amount
        FilteredContractRec."Annual Amount" := GridAnnualAmount;
        FilteredContractRec."Total Value" := MissedDays * FilteredContractRec."Per Day Rent";
        FilteredContractRec."Owner Share" := MissedDays * FilteredContractRec."Per Day Rent";
        FilteredContractRec."Final Annual Amount" := TotalAnnualAmount;
        FilteredContractRec."Posting Month" := PreviousMonthNo;
        FilteredContractRec."Posting Year" := PreviousYearNo;
        FilteredContractRec."Posting Period" := FetchMonth.GetMonthName(PreviousMonthNo) + ' ' +
            Format(PreviousYearNo) + ' ' + '-' + ' ' + FetchMonth.GetMonthName(PreviousMonthNo) + ' ' + Format(PreviousYearNo);
        FilteredContractRec."Owner Name" := ContractRec."Owner's Name";
        FilteredContractRec.Insert();

        // -----------------------------------------------
        // Insert grace period adjustment line (negative allocation) for missed days
        // Only if grace period dates overlap with the missed allocation period
        // -----------------------------------------------
        if ShouldInsertGraceLine then begin
            NewLineNo := GetNextLineNo();

            FilteredContractRec.Init();
            FilteredContractRec."Line No." := NewLineNo;
            FilteredContractRec."Header No." := Rec."No.";
            FilteredContractRec."Property Name" := ContractRec."Property Name";
            FilteredContractRec."Contract Id" := ContractRec."Contract ID";
            FilteredContractRec."Contract Tenure" := ContractRec."Contract Tenor";
            FilteredContractRec."Customer Name" := ContractRec."Customer Name";
            FilteredContractRec."Contract Start Date" := ContractRec."Contract Start Date";
            FilteredContractRec."Contract End Date" := ContractRec."Contract End Date";
            FilteredContractRec."Grace Days" := ContractRec."Grace Period";
            FilteredContractRec."Grace Start Date" := ContractRec."Grace Start Date";
            FilteredContractRec."Grace End Date" := ContractRec."Grace End Date";

            // Add Termination Date
            if TerminationDate = 0D then
                FilteredContractRec."Termination Date" := 0D
            else
                FilteredContractRec."Termination Date" := TerminationDate;

            if SuspensionRec.FindFirst() then begin
                FilteredContractRec."Suspension Start Date" := SuspensionRec.DateEffective;
                FilteredContractRec."Suspension End Date" := SuspensionRec.SuspensionEndDate;
            end;

            FilteredContractRec."Multi Year Start Date" := MultiYearStartDate;
            FilteredContractRec."Multi Year End Date" := MultiYearEndDate;
            FilteredContractRec."No Of Days" := MissedDays;
            FilteredContractRec."Per Day Rent" := -DifferencePerDayRent; // Negative value
            FilteredContractRec."Contract Amount" := ContractRec."Annual Rent Amount";
            FilteredContractRec."Annual Amount" := GridAnnualAmount;
            FilteredContractRec."Total Value" := -GracePeriodAdjustmentValue; // Negative adjustment
            FilteredContractRec."Owner Share" := -GracePeriodAdjustmentValue; // Negative adjustment
            FilteredContractRec."Final Annual Amount" := TotalAnnualAmount;
            FilteredContractRec."Posting Month" := PreviousMonthNo;
            FilteredContractRec."Posting Year" := PreviousYearNo;
            FilteredContractRec."Posting Period" := FetchMonth.GetMonthName(PreviousMonthNo) + ' ' +
                Format(PreviousYearNo) + ' ' + '-' + ' ' + FetchMonth.GetMonthName(PreviousMonthNo) + ' ' + Format(PreviousYearNo);
            FilteredContractRec."Owner Name" := ContractRec."Owner's Name";
            FilteredContractRec.Insert();
        end;
    end;
    // =======================INSERT GRACE PERIOD ADJUSTMENT LINE - ENDS HERE===========================================

    // SUMMARY: This procedure creates the actual allocation entries for missed revenue.
    //          It handles both regular rent allocation and grace period adjustments.
    //          The main line adds positive allocation, while the grace line (if applicable)
    //          adds negative adjustment to account for grace period discount effect.
    //          
    //          Result: Net allocation = Regular rent - Grace period adjustment
    // ==================================================================
    //---------------Fetch Contracts--------------//
    // ==================================================================
    // PROCEDURE: FetchContracts - STARTS HERE
    // ==================================================================
    // PURPOSE: Main procedure that orchestrates the entire revenue allocation process
    //          This is the entry point that processes all active contracts for a given month
    // 
    // WHEN USED: Called when user wants to generate revenue allocation for a specific month
    // 
    // LOGIC: 1. Clears existing data and sets up date ranges
    //        2. Processes each active contract
    //        3. Handles missed allocations from previous month
    //        4. Handles suspension recovery allocations
    //        5. Processes current month allocations for all rent types
    //        6. Calculates final totals
    // ==================================================================
    procedure FetchContracts()
    var
        // Record variables for different data sources
        FilterHeader: Record "Revenue Allocation Details";           // Header record
        ContractRec: Record "Tenancy Contract";                     // Main contract record
        FilteredContractRec: Record "Revenue Allocation SubGrid";    // Target allocation table
        SuspensionRec: Record SuspendReasonTable;                   // Suspension information
        FinalCalculationRec: Record "Final Calculation";            // Final calculation data

        // Rent type record variables
        SingleUnitRent: Record "TC Single Unit Rent SubPage";        // Single unit rent records
        MultiUnitRent: Record "TC Single LumAnnualAmnt SP";         // Multi unit rent records
        MergedSingleRent: Record "TC Merge SameSqure SubPage";      // Merged single rent records
        MergedMultiRent: Record "TC Merge DifferentSq SubPage";     // Merged multi rent records
        SpecialRent: Record "TC Merge LumAnnualAmount SP";          // Special rent records

        // Date and calculation variables
        SelectedMonthStart: Date;                                   // First day of selected month
        SelectedMonthEnd: Date;                                     // Last day of selected month
        MonthNo: Integer;                                           // Selected month number
        FinancialYear: Integer;                                     // Selected financial year
        LineNo: Integer;                                            // Line number for allocations
        TerminationDate: Date;                                      // Contract termination date
    begin
        // Clear any existing allocation data before processing
        ClearSubgridData();

        // Get month and year from current record
        MonthNo := Rec.Month;
        FinancialYear := Rec."Financial Year";

        // Calculate date range for the selected month
        SelectedMonthStart := DMY2Date(01, MonthNo, FinancialYear);
        SelectedMonthEnd := CALCDATE('<+1M-1D>', SelectedMonthStart);

        // Filter contracts to only include active contracts
        ContractRec.SetRange(ContractRec."Tenant Contract Status", ContractRec."Tenant Contract Status"::Active);

        if ContractRec.FindSet() then begin
            repeat
                // PURPOSE: Process only contracts that overlap with selected month
                // LOGIC: Contract start date <= month end AND contract end date >= month start
                if ((ContractRec."Contract Start Date" <= SelectedMonthEnd) and
                    (ContractRec."Contract End Date" >= SelectedMonthStart)) then begin

                    // Handle missed allocation from previous month (if contract started mid-month)
                    HandleMissedAllocation(ContractRec, MonthNo, FinancialYear);

                    // Handle suspension recovery allocation (new functionality)
                    HandleSuspensionRecoveryAllocation(ContractRec, MonthNo, FinancialYear);

                    // Retrieve termination date from Final Calculation table
                    FinalCalculationRec.Reset();
                    FinalCalculationRec.SetRange("Contract ID", ContractRec."Contract ID");
                    if FinalCalculationRec.FindFirst() then
                        TerminationDate := FinalCalculationRec."Termination Date"
                    else
                        TerminationDate := 0D;

                    // Process Single Unit Rent records
                    SingleUnitRent.Reset();
                    SingleUnitRent.SetRange("Contract ID", ContractRec."Contract ID");
                    if SingleUnitRent.FindSet() then begin
                        repeat
                            // Create allocation line for this Single Unit Rent record
                            InsertAllocationLine(
                                ContractRec,
                                SingleUnitRent."Start Date",
                                SingleUnitRent."End Date",
                                SingleUnitRent."Number of Days",
                                SingleUnitRent."Per Day Rent",
                                SingleUnitRent."Final Annual Amount",
                                SingleUnitRent."Final Annual Amount",
                                TerminationDate,
                                LineNo,  // Use sequential number
                                MonthNo,
                                FinancialYear);
                        // LineNo += 1;  // Increment by 1
                        until SingleUnitRent.Next() = 0;
                    end;

                    // Check Multi Unit Rent grid
                    MultiUnitRent.Reset();
                    MultiUnitRent.SetRange("Contract ID", ContractRec."Contract ID");
                    if MultiUnitRent.FindSet() then begin
                        repeat
                            // Create allocation line for this Multi Unit Rent record
                            InsertAllocationLine(
                                ContractRec,
                                MultiUnitRent."SL_Start Date",
                                MultiUnitRent."SL_End Date",
                                MultiUnitRent."SL_Number of Days",
                                MultiUnitRent."SL_Per Day Rent",
                                MultiUnitRent."SL_Final Annual Amount",
                                MultiUnitRent."SL_Final Annual Amount",
                                TerminationDate,
                                LineNo,  // Use sequential number
                                MonthNo,
                                FinancialYear);
                        // LineNo += 1;  // Increment by 1
                        until MultiUnitRent.Next() = 0;
                    end;

                    // Check Merged Single Rent grid
                    MergedSingleRent.Reset();
                    MergedSingleRent.SetRange("Contract ID", ContractRec."Contract ID");
                    if MergedSingleRent.FindSet() then begin
                        repeat
                            // Create allocation line for this Merged Single Rent record
                            InsertAllocationLine(
                                ContractRec,
                                MergedSingleRent."MS_Start Date",
                                MergedSingleRent."MS_End Date",
                                MergedSingleRent."MS_Number of Days",
                                MergedSingleRent."MS_Per Day Rent",
                                MergedSingleRent."MS_Final Annual Amount",
                                MergedSingleRent."MS_Final Annual Amount",
                                TerminationDate,
                                LineNo,  // Use sequential number
                                MonthNo,
                                FinancialYear);
                        // LineNo += 1;  // Increment by 1
                        until MergedSingleRent.Next() = 0;
                    end;

                    // Check Merged Multi Rent grid
                    MergedMultiRent.Reset();
                    MergedMultiRent.SetRange("Contract ID", ContractRec."Contract ID");
                    if MergedMultiRent.FindSet() then begin
                        repeat
                            // Create allocation line for this Merged Multi Rent record
                            InsertAllocationLine(
                                ContractRec,
                                MergedMultiRent."MD_Start Date",
                                MergedMultiRent."MD_End Date",
                                MergedMultiRent."MD_Number of Days",
                                MergedMultiRent."MD_Per Day Rent",
                                MergedMultiRent."MD_Final Annual Amount",
                                MergedMultiRent."MD_Final Annual Amount",
                                TerminationDate,
                                LineNo,  // Use sequential number
                                MonthNo,
                                FinancialYear);
                        // LineNo += 1;  // Increment by 1
                        until MergedMultiRent.Next() = 0;
                    end;

                    // Check Special Rent grid
                    SpecialRent.Reset();
                    SpecialRent.SetRange("Contract ID", ContractRec."Contract ID");
                    if SpecialRent.FindSet() then begin
                        repeat
                            // Create allocation line for this Special Rent record
                            InsertAllocationLine(
                                ContractRec,
                                SpecialRent."ML_Start Date",
                                SpecialRent."ML_End Date",
                                SpecialRent."ML_Number of Days",
                                SpecialRent."ML_Per Day Rent",
                                SpecialRent."ML_Final Annual Amount",
                                SpecialRent."ML_Final Annual Amount",
                                TerminationDate,
                                LineNo,  // Use sequential number
                                MonthNo,
                                FinancialYear);
                        // LineNo += 1;  // Increment by 1
                        until SpecialRent.Next() = 0;
                    end;
                end;
            until ContractRec.Next() = 0;
        end;
        CalculateTotals();
    end;

    //---------------Handle Suspension Recovery Allocation--------------//
    procedure HandleSuspensionRecoveryAllocation(
    ContractRec: Record "Tenancy Contract";
    MonthNo: Integer;
    FinancialYear: Integer)
    var
        SuspensionRec: Record SuspendReasonTable;
        CurrentMonthStart: Date;
        CurrentMonthEnd: Date;
        SuspensionStartDate: Date;
        SuspensionEndDate: Date;
        RecoveryStartDate: Date;
        RecoveryEndDate: Date;
        SingleUnitRent: Record "TC Single Unit Rent SubPage";
        MultiUnitRent: Record "TC Single LumAnnualAmnt SP";
        MergedSingleRent: Record "TC Merge SameSqure SubPage";
        MergedMultiRent: Record "TC Merge DifferentSq SubPage";
        SpecialRent: Record "TC Merge LumAnnualAmount SP";
        FinalCalculationRec: Record "Final Calculation";
        TerminationDate: Date;
        LineNo: Integer;
    begin
        // Calculate current month date range
        CurrentMonthStart := DMY2Date(1, MonthNo, FinancialYear);
        CurrentMonthEnd := CALCDATE('<CM>', CurrentMonthStart);

        // Check if contract was suspended and is now active
        SuspensionRec.Reset();
        SuspensionRec.SetRange("Contract ID", ContractRec."Contract ID");
        SuspensionRec.SetFilter(SuspensionEndDate, '<%1', CurrentMonthStart); // Suspension ended before current month

        if SuspensionRec.FindLast() then begin
            SuspensionStartDate := SuspensionRec.DateEffective;
            SuspensionEndDate := SuspensionRec.SuspensionEndDate;

            // Recovery period starts from suspension start date to suspension end date
            RecoveryStartDate := SuspensionStartDate;
            RecoveryEndDate := SuspensionEndDate;

            // Validate that suspension period is valid and ended
            if (SuspensionEndDate <> 0D) and (SuspensionEndDate < CurrentMonthStart) then begin

                // Retrieve Termination Date from Final Calculation
                FinalCalculationRec.Reset();
                FinalCalculationRec.SetRange("Contract ID", ContractRec."Contract ID");
                if FinalCalculationRec.FindFirst() then
                    TerminationDate := FinalCalculationRec."Termination Date"
                else
                    TerminationDate := 0D;

                // Process each rent type for suspension recovery allocation
                // Check Single Unit Rent grid
                SingleUnitRent.Reset();
                SingleUnitRent.SetRange("Contract ID", ContractRec."Contract ID");
                if SingleUnitRent.FindSet() then begin
                    repeat
                        if (SingleUnitRent."Start Date" <= RecoveryEndDate) and (SingleUnitRent."End Date" >= RecoveryStartDate) then begin
                            InsertSuspensionRecoveryLine(
                                ContractRec,
                                SingleUnitRent."Start Date",
                                SingleUnitRent."End Date",
                                SingleUnitRent."Number of Days",
                                SingleUnitRent."Per Day Rent",
                                SingleUnitRent."Final Annual Amount",
                                SingleUnitRent."Final Annual Amount",
                                TerminationDate,
                                LineNo,
                                MonthNo,
                                FinancialYear,
                                RecoveryStartDate,
                                RecoveryEndDate,
                                'Single Unit Rent Recovery');
                        end;
                    until SingleUnitRent.Next() = 0;
                end;

                // Check Multi Unit Rent grid
                MultiUnitRent.Reset();
                MultiUnitRent.SetRange("Contract ID", ContractRec."Contract ID");
                if MultiUnitRent.FindSet() then begin
                    repeat
                        if (MultiUnitRent."SL_Start Date" <= RecoveryEndDate) and (MultiUnitRent."SL_End Date" >= RecoveryStartDate) then begin
                            InsertSuspensionRecoveryLine(
                                ContractRec,
                                MultiUnitRent."SL_Start Date",
                                MultiUnitRent."SL_End Date",
                                MultiUnitRent."SL_Number of Days",
                                MultiUnitRent."SL_Per Day Rent",
                                MultiUnitRent."SL_Final Annual Amount",
                                MultiUnitRent."SL_Final Annual Amount",
                                TerminationDate,
                                LineNo,
                                MonthNo,
                                FinancialYear,
                                RecoveryStartDate,
                                RecoveryEndDate,
                                'Multi Unit Rent Recovery');
                        end;
                    until MultiUnitRent.Next() = 0;
                end;

                // Check Merged Single Rent grid
                MergedSingleRent.Reset();
                MergedSingleRent.SetRange("Contract ID", ContractRec."Contract ID");
                if MergedSingleRent.FindSet() then begin
                    repeat
                        if (MergedSingleRent."MS_Start Date" <= RecoveryEndDate) and (MergedSingleRent."MS_End Date" >= RecoveryStartDate) then begin
                            InsertSuspensionRecoveryLine(
                                ContractRec,
                                MergedSingleRent."MS_Start Date",
                                MergedSingleRent."MS_End Date",
                                MergedSingleRent."MS_Number of Days",
                                MergedSingleRent."MS_Per Day Rent",
                                MergedSingleRent."MS_Final Annual Amount",
                                MergedSingleRent."MS_Final Annual Amount",
                                TerminationDate,
                                LineNo,
                                MonthNo,
                                FinancialYear,
                                RecoveryStartDate,
                                RecoveryEndDate,
                                'Merged Single Rent Recovery');
                        end;
                    until MergedSingleRent.Next() = 0;
                end;

                // Check Merged Multi Rent grid
                MergedMultiRent.Reset();
                MergedMultiRent.SetRange("Contract ID", ContractRec."Contract ID");
                if MergedMultiRent.FindSet() then begin
                    repeat
                        if (MergedMultiRent."MD_Start Date" <= RecoveryEndDate) and (MergedMultiRent."MD_End Date" >= RecoveryStartDate) then begin
                            InsertSuspensionRecoveryLine(
                                ContractRec,
                                MergedMultiRent."MD_Start Date",
                                MergedMultiRent."MD_End Date",
                                MergedMultiRent."MD_Number of Days",
                                MergedMultiRent."MD_Per Day Rent",
                                MergedMultiRent."MD_Final Annual Amount",
                                MergedMultiRent."MD_Final Annual Amount",
                                TerminationDate,
                                LineNo,
                                MonthNo,
                                FinancialYear,
                                RecoveryStartDate,
                                RecoveryEndDate,
                                'Merged Multi Rent Recovery');
                        end;
                    until MergedMultiRent.Next() = 0;
                end;

                // Check Special Rent grid
                SpecialRent.Reset();
                SpecialRent.SetRange("Contract ID", ContractRec."Contract ID");
                if SpecialRent.FindSet() then begin
                    repeat
                        if (SpecialRent."ML_Start Date" <= RecoveryEndDate) and (SpecialRent."ML_End Date" >= RecoveryStartDate) then begin
                            InsertSuspensionRecoveryLine(
                                ContractRec,
                                SpecialRent."ML_Start Date",
                                SpecialRent."ML_End Date",
                                SpecialRent."ML_Number of Days",
                                SpecialRent."ML_Per Day Rent",
                                SpecialRent."ML_Final Annual Amount",
                                SpecialRent."ML_Final Annual Amount",
                                TerminationDate,
                                LineNo,
                                MonthNo,
                                FinancialYear,
                                RecoveryStartDate,
                                RecoveryEndDate,
                                'Special Rent Recovery');
                        end;
                    until SpecialRent.Next() = 0;
                end;
            end;
        end;
    end;

    //---------------Insert Suspension Recovery Line--------------//
    procedure InsertSuspensionRecoveryLine(
    ContractRec: Record "Tenancy Contract";
    MultiYearStartDate: Date;
    MultiYearEndDate: Date;
    NoOfDays: Integer;
    PerDayRent: Decimal;
    TotalAnnualAmount: Decimal;
    OwnerShareAmount: Decimal;
    TerminationDate: Date;
    LineNo: Integer;
    MonthNo: Integer;
    FinancialYear: Integer;
    RecoveryStartDate: Date;
    RecoveryEndDate: Date;
    RecoveryType: Text)
    var
        FilteredContractRec: Record "Revenue Allocation SubGrid";
        SuspensionRec: Record SuspendReasonTable;
        CalculatedRecoveryDays: Integer;
        NewLineNo: Integer;
        GridAnnualAmount: Decimal;
        RecoveryAmount: Decimal;
        EffectiveStartDate: Date;
        EffectiveEndDate: Date;
    begin
        // Get new line number
        NewLineNo := GetNextLineNo();

        // Use the annual amount from the grid record
        GridAnnualAmount := TotalAnnualAmount;

        // Calculate effective recovery period
        // Use the latest start date and earliest end date
        EffectiveStartDate := RecoveryStartDate;
        if MultiYearStartDate > EffectiveStartDate then
            EffectiveStartDate := MultiYearStartDate;

        EffectiveEndDate := RecoveryEndDate;
        if MultiYearEndDate < EffectiveEndDate then
            EffectiveEndDate := MultiYearEndDate;

        // Calculate recovery days
        if EffectiveStartDate <= EffectiveEndDate then
            CalculatedRecoveryDays := EffectiveEndDate - EffectiveStartDate + 1
        else
            CalculatedRecoveryDays := 0;

        // Only insert if there are days to recover
        if CalculatedRecoveryDays > 0 then begin
            // Calculate recovery amount
            RecoveryAmount := CalculatedRecoveryDays * PerDayRent;

            // Insert suspension recovery allocation line
            FilteredContractRec.Init();
            FilteredContractRec."Line No." := NewLineNo;
            FilteredContractRec."Header No." := Rec."No.";
            FilteredContractRec."Property Name" := ContractRec."Property Name";
            FilteredContractRec."Contract Id" := ContractRec."Contract ID";
            FilteredContractRec."Contract Tenure" := ContractRec."Contract Tenor";
            FilteredContractRec."Customer Name" := ContractRec."Customer Name";
            FilteredContractRec."Contract Start Date" := ContractRec."Contract Start Date";
            FilteredContractRec."Contract End Date" := ContractRec."Contract End Date";
            FilteredContractRec."Grace Days" := ContractRec."Grace Period";
            FilteredContractRec."Grace Start Date" := ContractRec."Grace Start Date";
            FilteredContractRec."Grace End Date" := ContractRec."Grace End Date";

            // Add Termination Date
            if TerminationDate = 0D then
                FilteredContractRec."Termination Date" := 0D
            else
                FilteredContractRec."Termination Date" := TerminationDate;

            // Add suspension information
            SuspensionRec.Reset();
            SuspensionRec.SetRange("Contract ID", ContractRec."Contract ID");
            if SuspensionRec.FindFirst() then begin
                FilteredContractRec."Suspension Start Date" := SuspensionRec.DateEffective;
                FilteredContractRec."Suspension End Date" := SuspensionRec.SuspensionEndDate;
            end;

            FilteredContractRec."Multi Year Start Date" := MultiYearStartDate;
            FilteredContractRec."Multi Year End Date" := MultiYearEndDate;
            FilteredContractRec."No Of Days" := CalculatedRecoveryDays;
            FilteredContractRec."Per Day Rent" := Round(PerDayRent);
            FilteredContractRec."Contract Amount" := ContractRec."Annual Rent Amount";
            FilteredContractRec."Annual Amount" := GridAnnualAmount;
            FilteredContractRec."Total Value" := RecoveryAmount;
            FilteredContractRec."Owner Share" := RecoveryAmount;
            FilteredContractRec."Final Annual Amount" := TotalAnnualAmount;
            FilteredContractRec."Posting Month" := MonthNo;
            FilteredContractRec."Posting Year" := FinancialYear;
            FilteredContractRec."Posting Period" := 'Suspension Recovery - ' + Format(MonthNo) + ' ' + Format(FinancialYear);
            FilteredContractRec."Owner Name" := ContractRec."Owner's Name";

            // Add a note to indicate this is suspension recovery
            // If you have a description field, uncomment below:
            // FilteredContractRec."Description" := RecoveryType + ' - Recovery Period: ' + 
            //     Format(EffectiveStartDate) + ' to ' + Format(EffectiveEndDate);

            FilteredContractRec.Insert();
        end;
    end;

    procedure CalculateAndStoreTotalRevenue()
    var
        revenueItemLine: Record "Revenue Recognition Details";
        revenueAllocLine: Record "Revenue Allocation Subgrid";
    begin
        Clear(totalcontractAmounts);
        Clear(totalamounts);

        revenueItemLine.SetRange("RR_No.", Rec."No.");
        if revenueItemLine.FindSet() then
            repeat
                totalcontractAmounts += revenueItemLine."Contract Amount";
                totalamounts += revenueItemLine."Total Value";
            until revenueItemLine.Next() = 0;


        revenueAllocLine.SetRange("Header No.", Rec."No.");
        if revenueAllocLine.FindSet() then
            repeat
                totalcontractAmountsss += revenueAllocLine."Contract Amount";
                totalamountsss += revenueAllocLine."Total Value";
                totalannualamountsss += revenueAllocLine."Annual Amount";
                totalfinalannualamountsss += revenueAllocLine."Final Annual Amount";
            until revenueAllocLine.Next() = 0;


        totalcombinecontractAmounts := totalcontractAmountsss + totalcontractAmounts;
        totalcombineamounts := totalamountsss + totalamounts;
    end;

    trigger OnAfterGetCurrRecord()
    begin
        CalculateAndStoreTotalRevenue();
    end;


    var

        totalcontractAmountsss: Decimal;
        totalamountsss: Decimal;
        totalannualamountsss: Decimal;
        totalfinalannualamountsss: Decimal;

        totalcontractAmounts: Decimal;
        totalamounts: Decimal;

        totalcombinecontractAmounts: Decimal;
        totalcombineamounts: Decimal;

    // trigger OnAfterGetRecord()
    // begin
    //     CurrPage."Revenue Recognition Item Details".Page.SetRIID(Rec."No.");
    //     CurrPage."Revenue Recognition Details".Page.SetRIID(Rec."No.");
    // end;


    trigger OnModifyRecord(): Boolean
    begin
        CurrPage."Revenue Recognition Item Details".Page.SetRIID(Rec."No.");
        CurrPage."Revenue Recognition Details".Page.SetRIID(Rec."No.");
    end;

    trigger OnInsertRecord(BelowxRec: Boolean): Boolean
    begin
        CurrPage."Revenue Recognition Item Details".Page.SetRIID(Rec."No.");
        CurrPage."Revenue Recognition Details".Page.SetRIID(Rec."No.");
        CalculateAndStoreTotalRevenue();
    end;
}
