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
    int H, W; get(H, W);
    auto F = new char[][H];
    int K;
    foreach (i; 0..H) foreach (c; readln.chomp.to!(char[])) {
        if (c == '#') ++K;
        F[i] ~= c;
    }
    auto ys = new int[](K);
    auto xs = new int[](K);
    auto memo = new bool[][](H, W);
    bool solve(int i, int j, int k) {
        ys[k] = i;
        xs[k] = j;
        if (k+1 == K) return true;

        memo[i][j] = true;
        static foreach (d; [[1,0], [0,1], [-1,0], [0,-1]]) {{
            auto ii = i + d[0];
            auto jj = j + d[1];
            if (0 <= ii && ii < H && 0 <= jj && jj < W && F[ii][jj] == '#' && !memo[ii][jj] && solve(ii, jj, k+1)) return true;
        }}
        memo[i][j] = false;
        return false;
    }
    foreach (i; 0..H) foreach (j; 0..W) if (F[i][j] == '#' && solve(i, j, 0)) {
        writeln(K);
        foreach (k; 0..K) writeln(ys[k] + 1, " ", xs[k] + 1);
        return;
    }
}