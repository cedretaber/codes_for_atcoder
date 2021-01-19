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
    int R, C, K; get(R, C, K);
    int N; get(N);
    auto rs = new int[](R);
    auto cs = new int[](C);
    int[] ys, xs;
    foreach (_; 0..N) {
        int r, c; get(r, c); --r; --c;
        ++rs[r];
        ++cs[c];
        ys ~= r;
        xs ~= c;
    }

    long[int] sc;
    foreach (c; cs) ++sc[c];

    long res;
    foreach (r; rs) {
        auto k = K - r;
        if (k in sc) res += sc[k];
    }
    foreach (i; 0..N) {
        auto r = rs[ys[i]];
        auto c = cs[xs[i]];
        if (r + c == K) {
            --res;
        } else if (r + c == K + 1) {
            ++res;
        }
    }
    writeln(res);
}