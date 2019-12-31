import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric, std.ascii;

alias W = Tuple!(string, string);

void main()
{
    auto S = readln.chomp;
    W[] ws;
    size_t i, j;
    for (; j < S.length; ++j) {
        if (!j) continue;

        if ('A' <= S[j] && S[j] <= 'Z') {
            ++j;
            auto w = S[i..j];
            ws ~= W(w, w.toLower);
            i = j;
        }
    }

    sort!"a[1] < b[1]"(ws);
    foreach (w; ws) write(w[0]);
    writeln("");
}