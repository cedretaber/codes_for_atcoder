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

enum U = 1<<11;
enum L = 1<<6;
enum M = 1<<5;
enum R = 1<<4;
enum MASK = 2^^12 - 1;

void main()
{
    char[][] SS; get_lines(18, SS);
    SS = SS ~ "000000".to!(char[]);

    long[2^^12] S;
    S[0] = 1;
    foreach (i; 0..19) foreach (j; 0..6) {
        long[2^^12] T;
        foreach (s; 0..2^^12) {
            int n;
            int t = (s & M) ? 1 : 0;
            if (s & U) ++n;
            if (j != 0 && (s & L)) ++n;
            n += t;
            if (j != 5 && (s & R)) ++n;

            void assign(int d) {
                if (t == 0 && n + d > 2) return;
                if (t == 1 && n + d < 3) return;

                T[((s << 1) & MASK) + d] += S[s];
            }
            if (SS[i][j] == '0') {
                assign(0);
            } else if (SS[i][j] == '1') {
                assign(1);
            } else {
                assign(0);
                assign(1);
            }
        }
        S = T;
    }

    writeln(S[].sum());
}

/*


..1098
765432
10*


*/
