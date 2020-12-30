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

alias R = Tuple!(int, "s", int, "t", int, "x");
alias A = Tuple!(int, "i", bool, "d", int, "x");

void main()
{
    int N, Q; get(N, Q);
    R[] rs;
    foreach (_; 0..N) {
        int s, t, x; get(s, t, x);
        rs ~= R(s, t, x);
    }
    A[] aa;
    foreach (r; rs) {
        aa ~= A(r.s - r.x, true, r.x);
        aa ~= A(r.t - r.x, false, r.x);
    }
    sort!"a.i < b.i"(aa);

    auto q = redBlackTree!("a < b", true)(int.max);
    while (Q--) {
        int d; get(d);
        while (!aa.empty && aa.front.i <= d) {
            auto a = aa.front;
            aa.popFront();
            if (a.d) {
                q.insert(a.x);
            } else {
                q.removeKey(a.x);
            }
        }
        auto r = q.front;
        writeln(r == int.max ? -1 : r);
    }
}