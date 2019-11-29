import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric;
import std.container : DList;

int[2][10^^5] GP;
bool[10^^5] MS;

alias S = Tuple!(int, "i", int, "c");

void main()
{
    auto K = readln.chomp.to!int;

    foreach (i; 1..K) {
        GP[i][0] = (i*10)%K;
        GP[i][1] = (i+1)%K;
    }

    auto ss = DList!S(S(1, 1));
    for (;;) {
        auto h = ss.front;
        if (!h.i) break;
        ss.removeFront();
        if (MS[h.i]) continue;
        MS[h.i] = true;

        auto n = GP[h.i];
        ss.insertFront(S(n[0], h.c));
        ss.insertBack(S(n[1], h.c+1));
    }

    writeln(ss.front.c);
}