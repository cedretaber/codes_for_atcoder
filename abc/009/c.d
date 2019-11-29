import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric;

void main()
{
    auto nk = readln.split.to!(int[]);
    auto N = nk[0];
    auto K = nk[1];
    auto S = readln.chomp.to!(char[]).map!(c => c.to!int - 97).array;
    
    int[] T;
    int[26] C, D;
    foreach (i; 0..N) {
        ++C[S[i]];
        ++D[S[i]];
    }

    foreach (i; 0..N) {
        --D[S[i]];
        foreach (int j; 0..26) {
            if (C[j] == 0) continue;
            --C[j];
            int d = N-i-1;
            if (S[i] != j) ++d;
            foreach (k; 0..26) d -= min(C[k], D[k]);
            if (d <= K) {
                T ~= j;
                if (S[i] != j) --K;
                break;
            }
            ++C[j];
        }
    }

    writeln(T.map!(c => (c + 97).to!char).array);
}