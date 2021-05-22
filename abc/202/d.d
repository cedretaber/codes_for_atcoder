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
    long A, B, K; get(A, B, K);

    auto cs = new long[][](31, 31);
    foreach (b; 0..31) {
        cs[0][b] = 1;
        cs[1][b] = b + 1;
    }
    foreach (long a; 2..31) foreach (long b; 0..31) cs[a][b] = cs[a - 1][b] / a * (a + b);
    writeln(cs);

    char[] res;
    void solve(long a, long b, long k) {
        writeln([a, b, k]);
        if (k == 0) {
            foreach (_; 0..a) res ~= 'a';
            foreach (_; 0..b) res ~= 'b';
            return;
        }

        auto d = cs[a - 1][b];
        if (k >= d) {
            res ~= 'b';
            solve(a, b - 1, k - d);
        } else {
            res ~= 'a';
            solve(a - 1, b, k);
        }
    }
    solve(A, B, K - 1);
    writeln(res);
}

/*

aabb
abab
abba
baab
baba
bbaa

abb
bab
bba

3 * 1/1

aabb
abab
abba
babb
bbab
bbba

4 * 3 * 1/2



*/
