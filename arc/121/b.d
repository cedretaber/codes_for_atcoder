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

enum RGB = ['R': 0, 'G': 1, 'B': 2];

void main()
{
    int N; get(N);
    long[][3] aa;
    foreach (ref a; aa) a.reserve(N * 2);
    foreach (_; 0..N * 2) {
        long A; char C; get(A, C);
        aa[RGB[C]] ~= A;
    }

    long[][] bb;
    long[] ee;
    foreach (i; 0..3) {
        if (aa[i].length % 2 == 1) {
            bb ~= aa[i];
        } else {
            ee = aa[i];
        }
    }
    if (bb.length == 0) return writeln(0);

    auto cc = redBlackTree(bb[1]);
    auto res = long.max;
    foreach (b; bb[0]) {
        if (!cc.equalRange(b).empty) return writeln(0);
        auto l = cc.lowerBound(b);
        if (!l.empty) res = min(res, abs(b - l.back));
        auto u = cc.upperBound(b);
        if (!u.empty) res = min(res, abs(b - u.front));
    }

    auto dd = redBlackTree(bb[0]);
    auto am = long.max / 3, bm = long.max / 3;
    foreach (e; ee) {
        {
            if (!cc.equalRange(e).empty) am = 0;
            auto l = cc.lowerBound(e);
            if (!l.empty) am = min(am, abs(e - l.back));
            auto u = cc.upperBound(e);
            if (!u.empty) am = min(am, abs(e - u.front));
        }
        {
            if (!dd.equalRange(e).empty) bm = 0;
            auto l = dd.lowerBound(e);
            if (!l.empty) bm = min(bm, abs(e - l.back));
            auto u = dd.upperBound(e);
            if (!u.empty) bm = min(bm, abs(e - u.front));
        }
    }
    writeln(min(res, am + bm));
}
