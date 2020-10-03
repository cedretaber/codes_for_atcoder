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
    int N; get(N);
    auto gs = new int[](2*N+1);
    auto os = new int[](2*N+1);
    auto ps = new int[](N+1);
    foreach (i; 1..N+1) {
        int A, B; get(A, B);
        if ((A != -1 && B != -1 && B <= A) || (A != -1 && gs[A] != 0) || (B != -1 && os[B] != 0)) {
            writeln("No");
            return;
        }
        if (A != -1) gs[A] = i;
        if (B != -1) os[B] = i;
        ps[i] = A != -1 && B != -1 ? 3 : A != -1 ? 2 : B != -1 ? 1 : 0;
    }

    bool solve(int i, int j) {
        if (j <= 2*N-1 && solve(i, j+2)) return true;

        auto o = (j - i) / 2;
        foreach (k; i..i+o) {
            if (gs[k+o] != 0 || os[k] != 0) return false;
            if (gs[k] != 0 && os[k+o] != 0) {
                if (gs[k] != os[k+o]) return false;
            } else if (gs[k] != 0) {
                if (ps[gs[k]] != 2) return false;
            } else if (os[k+o] != 0) {
                if (ps[os[k+o]] != 1) return false;
            }
        }
        return j == 2*N+1 || solve(j, j+2);
    }
    writeln(solve(1, 3) ? "Yes" : "No");
}

/*

3
1 -1
-1 4
-1 6


1 _
_ _
_ _
_ 2
_ _
_ 3


-> 後に載ってきた人よりも先に降りなければ行けないというルールx
   幾つかのグループに分けて、グループ内で順番に乗る・同じ順番で降りる、とする


2
-1 -1
-1 3

_ _
_ _
_ 2
_ _


2
-1 -1
-1 4

_ _
_ _
_ _
_ 2

3
-1 4
2 -1
3 6

_ _
2 _
3 _
_ 1
_ _
_ 3


3
4 -1
-1 5
-1 6

_ _
_ _
_ _
1 _
_ 2
_ 3



*/