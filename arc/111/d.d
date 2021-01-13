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

alias E = Tuple!(int, "i", int, "to", bool, "rev");
alias C = Tuple!(int, "i", int, "c");

void main()
{
    int N, M; get(N, M);
    auto G = new E[][N];
    foreach (i; 0..M) {
        int a, b; get(a, b); --a; --b;
        G[a] ~= E(i, b, false);
        G[b] ~= E(i, a, true);
    }
    auto ds = new int[](M);
    int[] cs; get(cs);
    C[] cc;
    foreach (i, c; cs) cc ~= C(i.to!int, c);
    sort!"a.c < b.c"(cc);

    auto memo = new int[](N);
    foreach (c; cc) {
        void solve(int i) {
            foreach (n; G[i]) if (ds[n.i] == 0) {
                ds[n.i] = n.rev ? 1 : -1;
                if (cs[n.to] == cs[c.i] && !memo[n.to]) {
                    memo[n.to] = true;
                    solve(n.to);
                }
            }
        }
        memo[c.i] = true;
        solve(c.i);
    }
    writefln!"%-(%s\n%)"(ds.map!(d => d == 1 ? "->" : "<-"));
}