// Bruno Ferreira Coelho - 92559

/*
Diagrama da máquina de estados
*/

module ff ( input data, input c, input r, output q);

    reg q;

    always @(posedge c or negedge r)
    begin
        if (r == 1'b0)
            q <= 1'b0;
        else
            q <= data;
    end

endmodule // End module ff

// ----   FSM alto nível com Case
module statem(clk, reset, a, saida);

    input clk, reset;
    input [1:0] a;
    output [2:0] saida;
    reg [2:0] state;

    parameter q0 = 3'd0, q1 = 3'd1, q2 = 3'd2, q3 = 3'd3, q4 = 3'd4, q5 = 3'd5, q6 = 3'd6, q7 = 3'd7;

    assign saida =  (state == q0) ? 3'd0:
                    (state == q1) ? 3'd1:
                    (state == q2) ? 3'd2:
                    (state == q3) ? 3'd3:
                    (state == q4) ? 3'd4:
                    (state == q5) ? 3'd5:
                    (state == q6) ? 3'd6:
                                    3'd7;

    always @(posedge clk or negedge reset)
    begin
        if (reset==0)
            state = q0;
        else
            case (state)
                q0: state = (a[1]) ? (a[0]) ? q1 : q1 : (a[0]) ? q1 : q1;
                q1: state = (a[1]) ? (a[0]) ? q2 : q3 : (a[0]) ? q2 : q2;
                q2: state = (a[1]) ? (a[0]) ? q4 : q7 : (a[0]) ? q4 : q0;
                q3: state = (a[1]) ? (a[0]) ? q5 : q2 : (a[0]) ? q2 : q2;
                q4: state = (a[1]) ? (a[0]) ? q3 : q3 : (a[0]) ? q3 : q3;
                q5: state = (a[1]) ? (a[0]) ? q6 : q6 : (a[0]) ? q6 : q6;
                q6: state = (a[1]) ? (a[0]) ? q3 : q3 : (a[0]) ? q3 : q3;
                q7: state = (a[1]) ? (a[0]) ? q1 : q1 : (a[0]) ? q1 : q1;
            endcase
        /*

        */
    end
endmodule

// FSM com portas logicas
module statePorta(input clk, input res, input a, output [2:0] saida);

    wire [2:0] state;
    wire [2:0] p;

    wire b, c, d;

    assign b = state[2];
    assign c = state[1];
    assign d = state[0];

    assign saida = state;

    assign p[0] =  (a & ~d) | (b & c & ~d);             // 6 portas lógicas
    assign p[1] =  (~c & d) | (b & c & ~d) | (~a & b);  // 8 portas lógicas
    assign p[2] =  (a & d) | (~a & ~c) | (c & ~d);      // 8 portas lógicas

    // Total de 24 portas lógicas

    ff  e0(p[0], clk, res, state[0]);
    ff  e1(p[1], clk, res, state[1]);
    ff  e2(p[2], clk, res, state[2]);

endmodule // End Module statePorta

module stateMem(input clk,input res, input [1:0] a, output [2:0] saida);

    reg [5:0] StateMachine [0:31]; // 16 linhas e 6 bits de largura
    initial
    begin  // programar ainda....
        StateMachine[0] = 6'o10;
        StateMachine[1] = 6'o21;
        StateMachine[2] = 6'o02;
        StateMachine[3] = 6'o23;
        StateMachine[4] = 6'o34;
        StateMachine[5] = 6'o65;
        StateMachine[6] = 6'o36;
        StateMachine[7] = 6'o17;

        StateMachine[8] = 6'o10;
        StateMachine[9] = 6'o21;
        StateMachine[10] = 6'o42;
        StateMachine[11] = 6'o23;
        StateMachine[12] = 6'o34;
        StateMachine[13] = 6'o65;
        StateMachine[14] = 6'o36;
        StateMachine[15] = 6'o17;

        StateMachine[16] = 6'o10;
        StateMachine[17] = 6'o31;
        StateMachine[18] = 6'o72;
        StateMachine[19] = 6'o23;
        StateMachine[20] = 6'o34;
        StateMachine[21] = 6'o65;
        StateMachine[22] = 6'o36;
        StateMachine[23] = 6'o17;

        StateMachine[24] = 6'o10;
        StateMachine[25] = 6'o21;
        StateMachine[26] = 6'o42;
        StateMachine[27] = 6'o53;
        StateMachine[28] = 6'o34;
        StateMachine[29] = 6'o65;
        StateMachine[30] = 6'o36;
        StateMachine[31] = 6'o17;
    end

    wire [4:0] address;  // 32 linhas = 5 bits de endereco
    wire [5:0] dout; // 6 bits de largura 3+3 = proximo estado + saida

    assign address[3] = a[0];
    assign address[4] = a[1];

    assign dout = StateMachine[address];

    assign saida = dout[2:0];

    ff st0(dout[3],clk,res,address[0]);
    ff st1(dout[4],clk,res,address[1]);
    ff st2(dout[5],clk,res,address[2]);
endmodule

module main;

    reg c,res;
    reg [1:0] a;
    wire [2:0] saida;
    wire [2:0] saida1;
    wire [2:0] saida2;

    statem FSM(c, res, a, saida);
    stateMem FSM1(c, res, a, saida1);
    //statePorta FSM2(c, res, a, saida2);

    initial
        c = 1'b0;
    always
        c= #(1) ~c;

    // visualizar formas de onda usar gtkwave out.vcd
    initial
    begin
        $dumpfile ("out.vcd");
        $dumpvars;
    end

    initial
    begin
        $monitor($time," A: \"%b\"  Case: \"%d\" Memória \"%d\"",a,saida,saida1);
        //Matricula: 92559 -> 01 01 10 10 01 10 00 11 11 -> 1 1 2 2 1 2 0 3 3
        #1 res=0; a=0;
        #1 res=1;
        #4 a=1;
        #4 a=2;
        #4 a=2;
        #4 a=1;
        #4 a=2;
        #4 a=0;
        #4 a=3;
        #4 a=3;
        #3;
        $finish;
    end

endmodule