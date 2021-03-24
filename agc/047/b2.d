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
    string[] SS; get_lines(N, SS);

    bool[26] cs;
    long[][string] memo;
    bool[size_t] lens;
    foreach (s; SS) {
        auto c = s[0] - 'a';
        if (s.length == 1) {
            cs[c] = true;
        } else {
            auto key = s[1..$];
            lens[key.length] = true;
            if (key !in memo) memo[key].length = 26;
            ++memo[key][c];
        }
    }

    long res;
    foreach (s; SS) if (s.length > 1) {
        bool[26] ok;
        foreach (i; 0..s.length - 1) {
            ok[s[i] - 'a'] = true;
            if (s.length - i - 1 in lens && s[i + 1..$] in memo) foreach (j; 0..26) if (ok[j]) res += memo[s[i + 1..$]][j];
        }
        ok[s[$-1] - 'a'] = true;
        foreach (i; 0..26) if (ok[i] && cs[i]) ++res; 
        --res;
    }
    writeln(res);
}
