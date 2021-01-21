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
    int[] BS; get_lines(N-1, BS);

    int max_b;
    if (BS[0] != 1) {
        if (BS[0] != 2) return writeln(0);
        max_b = 1;
        foreach (b; BS) {
            if (b > max_b + 1) return writeln(0);
            max_b = max(max_b, b);
        }
        return writeln(1);
    }

    long res = 1;
    foreach (i, b; BS) {
        if (b <= max_b + 1) {
            res += max_b;
            max_b = max(max_b, b);
        } else if (b == max_b + 2) {
            auto t = max_b;
            max_b = 0;
            res = 0;
            foreach (c; BS[0..i]) {
                max_b = max(max_b, c);
                if (max_b == t) ++res;
            }
            max_b += 2;
            foreach (c; BS[i+1..$]) {
                if (c > max_b + 1) return writeln(0);
                max_b = max(max_b, c);
            }
            return writeln(res);
        } else {
            return writeln(0);
        }
    }
    res += max_b;
    writeln(res);
}

/*

4
<- 1
1
<- 1,2
1
<- 1,2
2
<- 1,2,3

8
<- 1
1
<- 2
1
<- 2
2
<- 1,3
1
<- 2,3
2
<- 1,3
3
<- 1,2,4
1
<- 2,3,4


4
<- 1
2
<- _
3
<- _
4
<- _
5
<- _
=> 1

6
<- _
1
<- 2
1
<- 2
1
<- 2
3
<- _
1
<- _
2
<- _
=> 3


2
<- _
1
<- _
10
<- _
=> 0

5
2
3
4
6

*/