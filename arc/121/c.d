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
    int T; get(T); while (T--) {
        int N; get(N);
        int[] ps; get(ps);

        int[] rs;
        if (N >= 5) foreach_reverse (x; 4..N) {
            int i;
            while (ps[i] != x + 1) ++i;
            if (rs.length % 2 != i % 2) {
                if (rs.length % 2 == 0) {
                    if (i == 1) {
                        rs ~= 3;
                        swap(ps[2], ps[3]);
                    } else {
                        rs ~= 1;
                        swap(ps[0], ps[1]);
                    }
                } else {
                    if (i == 2) {
                        rs ~= [2, 1, 2, 1, 2];
                        swap(ps[1], ps[2]);
                        swap(ps[0], ps[1]);
                        swap(ps[1], ps[2]);
                        swap(ps[0], ps[1]);
                        swap(ps[1], ps[2]);
                    } else {
                        rs ~= 2;
                        swap(ps[1], ps[2]);
                    }
                }
            }
            foreach (j; i..x) {
                rs ~= j + 1;
                swap(ps[j], ps[j + 1]);
            }
        }
        if (N >= 4) {
            if (ps[0] == 4) {
                if (rs.length % 2 == 1) {
                    rs ~= 2;
                    swap(ps[1], ps[2]);
                }
                rs ~= [1, 2, 3];
                swap(ps[0], ps[1]);
                swap(ps[1], ps[2]);
                swap(ps[2], ps[3]);
            } else if (ps[1] == 4) {
                if (rs.length % 2 == 0) {
                    rs ~= 3;
                    swap(ps[2], ps[3]);
                }
                rs ~= [2, 3];
                swap(ps[1], ps[2]);
                swap(ps[2], ps[3]);
            } else if (ps[2] == 4) {
                if (rs.length % 2 == 1) {
                    rs ~= [2, 3, 2];
                    swap(ps[1], ps[2]);
                    swap(ps[2], ps[3]);
                    swap(ps[1], ps[2]);
                }
                rs ~= 3;
                swap(ps[2], ps[3]);
            }
        }
        if (N >= 3) while (ps[0..3] != [1, 2, 3]) {
            if (rs.length % 2 == 0) {
                rs ~= 1;
                swap(ps[0], ps[1]);
            } else {
                rs ~= 2;
                swap(ps[1], ps[2]);
            }
        }
        if (N == 2 && ps[0] == 2) {
            rs ~= 1;
        }
        writeln(rs.length);
        writefln!"%(%d %)"(rs);
    }
}

/*

1 2 4 3
  *
1 4 2 3
    *
1 4 3 2
  *
1 3 4 2
    *
1 3 2 4


*/
