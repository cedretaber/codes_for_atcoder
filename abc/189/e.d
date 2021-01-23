import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric, std.container, std.range;

void get(Args...)(ref Args args)
{
    import std.traits, std.meta, std.typecons;

    static if (Args.length == 1) {
        alias Arg = Args[0];
        
        static if (isArray!Arg) {
          static if (isSomeChar!(ElementType!Arg)) {
            args[0] = readln.chomp.to!Arg;
          } else {
            args[0] = readln.split.to!Arg;
          }
        } else static if (isTuple!Arg) {
            auto input = readln.split;
            static foreach (i; 0..Fields!Arg.length) {
                args[0][i] = input[i].to!(Fields!Arg[i]);
            }
        } else {
            args[0] = readln.chomp.to!Arg;
        }
    } else {
        auto input = readln.split;
        assert(input.length == Args.length);

        static foreach (i; 0..Args.length) {
            args[i] = input[i].to!(Args[i]);
        }
    }
}

void get_lines(Args...)(size_t N, ref Args args)
{
    import std.traits, std.range;

    static foreach (i; 0..Args.length) {
        static assert(isArray!(Args[i]));
        args[i].length = N;
    }

    foreach (i; 0..N) {
        static if (Args.length == 1) {
            get(args[0][i]);
        } else {
            auto input = readln.split;
            static foreach (j; 0..Args.length) {
                args[j][i] = input[j].to!(ElementType!(Args[j]));
            }
        }
    }
}

alias P = Tuple!(long, "x", long, "y");
alias Q = Tuple!(int, "i", int, "a", int, "b");

void main()
{
    int N; get(N);
    P[] ps; get_lines(N, ps);

    int M; get(M);
    int[] op1;
    long[] op2;
    foreach (_; 0..M) {
        string op; get(op);
        if (op == "1") {
            op1 ~= 1;
            op2 ~= 0;
        } else if (op == "2") {
            op1 ~= 2;
            op2 ~= 0;
        } else if (op[0] == '3') {
            op1 ~= 3;
            op2 ~= op.split[1].to!long;
        } else {
            op1 ~= 4;
            op2 ~= op.split[1].to!long;
        }
    }
    
    int q; get(q);
    Q[] qs;
    foreach (i; 0..q) {
        int A, B; get(A, B);
        qs ~= Q(i, A - 1, B - 1);
    }
    sort!"a.a < b.a"(qs);

    auto rx = new long[](q);
    auto ry = new long[](q);
    while (!qs.empty && qs.front.a == -1) {
        auto i = qs.front.i;
        auto p = ps[qs.front.b];
        qs.popFront();
        rx[i] = p.x;
        ry[i] = p.y;
    }
    long x = 1, y = 1, cx, cy;
    int s;
    foreach (i; 0..M) {
        switch (op1[i]) {
            case 1:
                ++s;
                swap(x, y);
                swap(cx, cy);
                y = -y;
                cy = -cy;
                break;
            case 2:
                ++s;
                swap(x, y);
                swap(cx, cy);
                x = -x;
                cx = -cx;
                break;
            case 3:
                auto c = op2[i];
                x = -x;
                cx = 2 * c - cx;
                break;
            case 4:
                auto c = op2[i];
                y = -y;
                cy = 2 * c - cy;
                break;
            default:
        }

        while (!qs.empty && qs.front.a == i) {
            auto p = ps[qs.front.b];
            auto j = qs.front.i;
            qs.popFront();
            if (s % 2 == 0) {
                rx[j] = p.x * x + cx;
                ry[j] = p.y * y + cy;
            } else {
                rx[j] = p.y * x + cx;
                ry[j] = p.x * y + cy;
            }
        }
    }

    foreach (i; 0..q) writeln(rx[i], " ", ry[i]);
}

/*

f1(x, y) -> (y, -x)
f2(x, y) -> (-y, x)
f3(x, y, p) -> (2p - x, y)
f4(x, y, p) -> (x, 2p - y)


f3(f1(f4(f2(x, y), 3)), 5)
f2(x, y) -> (-y, x)
f4(-y, x, 3) -> (6+y, x)
f1(6+y, x) -> (x, -(6+y))
f3(x, -(6+y), 5) -> (10 - x, -6-y)


f3(f3(x, y, 3),5)
f3(x, y, 3) -> (6 - x, y)
f3(6-x, y, 5) -> (10 - (6-x), y) <=> (4 + x, y) 

*/