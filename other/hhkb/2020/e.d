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

enum P = 10L^^9+7;
long[2000^^2+50] F, RF;

long pow(long x, long n) {
    long y = 1;
    while (n) {
        if (n%2 == 1) y = (y * x) % P;
        x = x^^2 % P;
        n /= 2;
    }
    return y;
}

void main()
{
    int H, W; get(H, W);
    char[][] MAP; get_lines(H, MAP);

    long p;
    foreach (i; 0..H) foreach (j; 0..W) if (MAP[i][j] == '.') ++p;

    auto LS = new long[][](H, W);
    foreach (ref ls; LS) ls[] = -1;
    foreach (i; 0..H) {
        int s = -1;
        foreach (j; 0..W) {
            if (s == -1 && MAP[i][j] == '.') {
                s = j;
            } else if (s != -1 && MAP[i][j] == '#') {
                foreach (k; s..j) LS[i][k] += j-s;
                s = -1;
            }
        }
        if (s != -1) foreach (k; s..W) LS[i][k] += W-s;
    }
    foreach (j; 0..W) {
        int s = -1;
        foreach (i; 0..H) {
            if (s == -1 && MAP[i][j] == '.') {
                s = i;
            } else if (s != -1 && MAP[i][j] == '#') {
                foreach (k; s..i) LS[k][j] += i-s;
                s = -1;
            }
        }
        if (s != -1) foreach (k; s..H) LS[k][j] += H-s;
    }

    long r;
    foreach (ls; LS) foreach (n; ls) if (n > 0) (r += (pow(2, p) - pow(2, p-n) + P) % P) %= P;
    writeln(r);
}