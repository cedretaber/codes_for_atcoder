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
    int c;
    int[string] cs;
    auto to = new int[](N);
    auto from = new int[][N * 2];
    foreach (i; 0..N) {
        string s; get(s);
        int h, t;
        if (s[0..3] !in cs) cs[s[0..3]] = c++;
        h = cs[s[0..3]];
        if (s[$ - 3..$] !in cs) cs[s[$ - 3..$]] = c++;
        t = cs[s[$ - 3..$]];

        from[h] ~= i;
        to[i] = t;
    }

    auto res = new int[](N);
    res[] = -2;
    foreach (i; 0..N) {
        int solve(int x) {
            res[x] = -3;
            auto r = -2;
            if (from[to[x]].empty) r = 1;
            foreach (o; from[to[x]]) {
                if (res[o] == -2) {
                    r = max(r, solve(o));
                } else if (res[o] == -3) {
                    r = max(r, 0);
                } else {
                    r = max(r, -res[o]);
                }
            }
            res[x] = r;
            return -r;
        }
        if (res[i] == -2) solve(i);
        writeln(res[i] == 1 ? "Takahashi" : res[i] == -1 ? "Aoki" : "Draw");
    }
}
