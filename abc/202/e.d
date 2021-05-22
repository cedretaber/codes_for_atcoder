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

void main()
{
    int N; get(N);
    auto T = new int[][N];
    int[] PS; get(PS);
    foreach (i, p; PS) T[p - 1] ~= i.to!int + 1;
    int q; get(q);
    alias Q = Tuple!(int, "i", int, "u", int, "d");
    auto qs = Q[][N];
    foreach (i; 0..q) {
        int U, D; get(U, D); --U;
        qs[U] ~= Q(i, U, D);
    }
    auto ps = new Q[][N + 1];
    void run(int i, int d) {
        foreach (q; qs[i]) ps[q.d] ~= q;
        foreach (j; T[i]) run(j, d + 1);
    }
    run(0, 0);

    auto res = new int[](N + 1);
    foreach (i; 0..N + 1) res[i].length = ps[i].length;
    void solve(int i, int d) {
    }
    solve(0, 0);
    writefln!"%(%d\n%)"(res);
}
