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

int parse(string s)
{
    int r;
    r += s[0..2].to!int * 60 * 60 * 1000;
    r += s[3..5].to!int * 60 * 1000;
    r += s[6..8].to!int * 1000;
    r += s[9..$].to!int;
    return r;
}

void main()
{
    int N; get(N);
    int[] ss, ts;
    int max_s = int.min, min_t = int.max;
    foreach (i; 0..N) {
        string[] st; get(st);
        auto s = parse(st[0]);
        auto t = parse(st[1]);
        ss ~= s;
        ts ~= t;
        if (t <= s) {
            max_s = max(max_s, s);
            min_t = min(min_t, t);
        }
    }
    bool is_skeptical(int x) {
        return max_s - 1000 < x && x < min_t + 1000;
    }
    auto res = new int[](N);
    res[] = -1;
    if (max_s != int.min) {
            foreach (i; 0..N) {
            if (ts[i] <= ss[i] || (ss[i] <= max_s - 1000 && min_t + 1000 <= ts[i])) {
                res[i] = ts[i] - ss[i] + 1000;
            } else if (!is_skeptical(ss[i]) && !is_skeptical(ts[i])) {
                res[i] = ts[i] - ss[i];
            }
        }
    }
    writefln!"%(%d\n%)"(res);
}