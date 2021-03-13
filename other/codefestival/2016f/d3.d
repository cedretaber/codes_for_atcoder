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
    int N, M; get(N, M);
    int[] XS; get(XS);
    auto es = new int[](M);
    auto os = new int[][M];

    sort(XS);
    XS ~= -1;
    int last, cnt;
    foreach (x; XS) {
        if (x != last) {
            if (cnt) {
                if (cnt % 2 == 0) {
                    es[last % M] += cnt;
                } else {
                    os[last % M] ~= cnt;
                }
            }
            last = x;
            cnt = 0;
        }
        ++cnt;
    }

    int r;
    foreach (i; 0..M / 2 + 1) {
        if (i == 0 || i * 2 == M) {
            int s = es[i];
            foreach (x; os[i]) s += x;
            r += s / 2;
            continue;
        }

        auto j = M - i;
        int s = es[i] + es[j];
        foreach (x; os[i]) s += x;
        foreach (x; os[j]) s += x;
        if (os[i].length > os[j].length) swap(i, j);
        auto rest = (os[j].length - os[i].length).to!int;
        foreach (x; os[i]) es[i] += x - 1;
        s -= max(0, rest - es[i]);
        r += s / 2;
    }
    writeln(r);
}
