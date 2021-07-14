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
    char[] S; get(S);
    DList!int C;

    bool remove(int count, bool rev) {
        int[] ss;
        scope (exit) {
            while (!ss.empty) {
                if (rev) {
                    C.insertBack(ss[$ - 1]);
                } else {
                    C.insertFront(ss[$ - 1]);
                }
                ss = ss[0..$ - 1];
            }
        }
        foreach (_; 0..count) {
            if (C.empty) return true;
            if (rev) {
                ss ~= C.back;
                C.removeBack();
            } else {
                ss ~= C.front;
                C.removeFront();
            }
        }
        writeln(ss[$ - 1]);
        ss = ss[0..$ - 1];
        return false;
    }

    foreach (i, c; S) {
        switch (c) {
            case 'A': if (remove(1, false)) goto default; break;
            case 'B': if (remove(2, false)) goto default; break;
            case 'C': if (remove(3, false)) goto default; break;
            case 'D': if (remove(1, true)) goto default; break;
            case 'E': if (remove(2, true)) goto default; break;
            case 'F': if (remove(3, true)) goto default; break;
            case 'L': C.insertFront(i.to!int + 1); break;
            case 'R': C.insertBack(i.to!int + 1); break;
            default: writeln("ERROR");
        }
    }
}
