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
    char[][] B; get_lines(19, B);
    int b, w;
    foreach (i; 0..19) foreach (j; 0..19) {
        if (B[i][j] == 'o') {
            ++b;
        } else if (B[i][j] == 'x') {
            ++w;
        }
    }
    if (w > b || b - w > 1) return writeln("NO");
    if (b == 0) return writeln("YES");

    bool is_win(char t) {
        int count(int i, int j, int di, int dj) {
            if (B[i][j] != t) return 0;
            int r = 1;
            i += di; j += dj;
            if (0 <= i && i < 19 && 0 <= j && j < 19) r += count(i, j, di, dj);
            return r;
        }
        foreach (i; 0..19) foreach (j; 0..19) if (B[i][j] == t) {
            if (count(i, j, 1, 0) >= 5) return true;
            if (count(i, j, 0, 1) >= 5) return true;
            if (count(i, j, 1, 1) >= 5) return true;
            if (count(i, j, -1, 1) >= 5) return true;
        }
        return false;
    }

    auto b_win = is_win('o');
    auto w_win = is_win('x');
    if (b_win && w_win) return writeln("NO");
    if (b > w && w_win) return writeln("NO");
    if (b == w && b_win) return writeln("NO");
    
    auto last = b > w ? 'o' : 'x';
    foreach (i; 0..19) foreach (j; 0..19) if (B[i][j] == last) {
        B[i][j] = '.';
        if (b_win && is_win('o')) goto next;
        if (w_win && is_win('x')) goto next;

        return writeln("YES");

        next:
        B[i][j] = last;
    }

    writeln("NO");
}
