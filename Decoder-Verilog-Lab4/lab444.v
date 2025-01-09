module LedCPUcore(
  input clk,
  input rst,
  output reg [7:0] addrRd,
  input [15:0] dataRd,
  output reg [7:0] outPattern
);

  reg [7:0] addrRdNext;
  reg [7:0] outPatternNext;
  reg [7:0] processTime, processTimeNext; // Counter for delay cycles

  // Sequential block: Update registers at every clock cycle
 reg [31:0] clkDivider;      
    reg slowClk;                 
    parameter MAX_COUNT = 1_000_000; 

    always @(posedge clk or posedge rst) begin
        if (rst) begin
            clkDivider <= 32'b0;
            slowClk <= 1'b0;
        end else if (clkDivider == MAX_COUNT - 1) begin
            clkDivider <= 32'b0;
            slowClk <= ~slowClk; 
        end else begin
            clkDivider <= clkDivider + 1;
        end
    end

 
 
 
  always @(posedge slowClk or posedge rst) begin
    if (rst) begin
      addrRd <= 8'b0;            // Reset address
      outPattern <= 8'b0;        // Reset LED pattern
      processTime <= 8'b0;       // Reset delay counter
    end else begin
      addrRd <= addrRdNext;      // Update address
      outPattern <= outPatternNext; // Update LED pattern
      processTime <= processTimeNext; // Update delay counter
    end
  end

  // Combinational block: Logic for next state
  always @(*) begin
    // Default values to prevent latches
    addrRdNext = addrRd;
    outPatternNext = outPattern;
    processTimeNext = processTime;

    if (rst) begin
      addrRdNext = 8'b0;          // Reset address on reset
      outPatternNext = 8'b0;      // Reset LED pattern
      processTimeNext = 8'b0;     // Reset delay counter
    end else begin
      if (processTime > 0) begin
        // If delay is active, decrement the counter and hold the current pattern
        processTimeNext = processTime - 1;
      end else begin
        // Fetch new instruction
        if (dataRd[7:0] == 8'b0) begin
          // Jump operation
          addrRdNext = dataRd[15:8]; // Update PC with address from bits [15:8]
        end else begin
          // Output operation
          outPatternNext = dataRd[15:8]; // Set LED pattern from bits [15:8]
          processTimeNext = dataRd[7:0]; // Set delay from bits [7:0]
          addrRdNext = addrRd + 1;       // Move to next address
        end
      end
    end
  end
endmodule
