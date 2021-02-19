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

alias P = Tuple!(int, "i", int, "l");

void main()
{
    int R, C, N; get(R, C, N);

    int pos(int x, int y) {
        if (x == 0) {
            return y;
        } else if (x == R) {
            return R + C * 2 - y;
        } else if (y == 0) {
            if (x == 0) return 0;
            return R * 2 + C * 2 - x;
        } else {
            return C + x;
        }
    }

    P[] ps;
    foreach (i; 0..N) {
        int x1, y1, x2, y2; get(x1, y1, x2, y2);
        if (0 < x1 && x1 < R && 0 < y1 && y1 < C) continue;
        if (0 < x2 && x2 < R && 0 < y2 && y2 < C) continue;
        ps ~= P(i, pos(x1, y1));
        ps ~= P(i, pos(x2, y2));
    }
    sort!"a.l < b.l"(ps);
    
    auto stk = SList!int();
    foreach (p; ps) {
        if (!stk.empty && stk.front == p.i) {
            stk.removeFront();
        } else {
            stk.insert(p.i);
        }
    }
    writeln(stk.empty ? "YES" : "NO");
}