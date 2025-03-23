function FF = fadf(z)
ind_neg = imag(z)<0; % if some imag(z) values are negative, then ...
z(ind_neg) = conj(z(ind_neg)); % ... bring them to the upper-half plane
FF = zeros(size(z)); % define array
ind_ext  = abs(z)>8; % external indices
ind_band = ~ind_ext & imag(z)<5*10^-3; % narrow band indices
FF(~ind_ext & ~ind_band) = ...
    fexp(z(~ind_ext & ~ind_band)); % internal area. This area is ...
    % ... the most difficult for accurate computation
FF(ind_ext) = contfr(z(ind_ext)); % external area
FF(ind_band) = smallim(z(ind_band)); % narrow band
    function FE = fexp(z,tauM,maxN) % Fourier expansion approximation, ...
        % ... see [1, 2] for more information
        if nargin == 1 % assign default paramenetrs tauM and maxN
            tauM = 12; % the margin value
            maxN = 23; % the upper limit summation integer
        end
        n = 1:maxN; % initiate an array
        aN = 2*sqrt(pi)/tauM*exp(-n.^2*pi^2/tauM^2); % Fourier coefficients
        z1 = exp(1i*tauM*z); % define first repeating array
        z2 = tauM^2*z.^2; % define second repeating array
        FE = sqrt(pi)/tauM*(1 - z1)./z2; % initiate array FE
        for n = 1:maxN
            FE = FE + (aN(n)*((-1)^n*z1 - 1)./(n^2*pi^2 - z2));
        end
        FE = 1i*tauM^2*z/sqrt(pi).*FE;
    end

    function CF = contfr(z) % the Laplace continued fraction approximation
        bN = 11; % initial integer
        bN = 1:bN;
        bN = bN/2;
        CF = bN(end)./z; % start computing from the last bN
        for k = 1:length(bN) - 1
            CF = bN(end-k)./(z - CF);
        end
        CF = 1i/sqrt(pi)./(z - CF);
    end
    function SIm = smallim(z) % approximation at small imag(z)
        ind_0 = abs(real(z))<5*1e-3;
        % If |Re[z]| < 5*1e-3, then:
        SIm(ind_0) = small_z(z(ind_0));
        x = real(z); % define the repeating array
        ind_poles = false(size(x)); % initiate the array of indices
        k = 1; % the counter
        while k <= 23
            % These indices are to avoid the poles that can strongly ...
            % ... deteriorate the accuracy in computation
            ind_poles = ind_poles | abs(x - k*pi/12)<1e-4;
            k = k + 1; % just to increment the counter
        end
        % Else if |Re[z]| >= 5*1e-3, then:
        SIm(~ind_0 & ~ind_poles) = narr_band(z(~ind_0 & ~ind_poles));
        % -----------------------------------------------------------------
        % Note that the margin value tauM in the line below is taken as ...
        % 12.1 instead of the default value 12. This excludes all poles ...
        % in computation even if Im[z] -> 0.
        SIm(~ind_0 & ind_poles) = narr_band(z(~ind_0 & ind_poles),12.1,23);
        % -----------------------------------------------------------------
        function SZ = small_z(z)
            % This equation improves accuracy near the origin. It is ...
            % obtained by the Maclaurin series expansion.
            % Define the repeating arrays
            zP2=z.^2;
            zP4=zP2.^2;
            zP6=zP2.*zP4;
            SZ = (((6 - 6*zP2 + 3*zP4 - zP6).*(15*sqrt(pi) + ...
                1i*z.*(30 + 10*zP2 + 3*zP4)))/(90*sqrt(pi)));
        end
        function NB = narr_band(z,tauM,maxN) % the narrow band
            % This is just an alternative representation of the ...
            % equation (14) from [1].
            if nargin == 1 % define default parameters
                    tauM = 12; % the margin value
                    maxN = 23; % the upper limit summation integer
            end
            n = 1:maxN; % initiate an array
            aN = 2*sqrt(pi)/tauM*exp(-n.^2*pi^2/tauM^2); % The Fourier ...
                                         % ... expansion coeffisients
            z1 = cos(tauM*z); % define first repeating array
            z2 = tauM^2*z.^2; % define second repeating array
            NB = 0; % initiate the array NB
            for n = 1:maxN
                NB = NB + (aN(n)*((-1)^n*z1 - 1)./(n^2*pi^2 - z2));
            end
            NB = exp(-z.^2) - 1i*((z1 - 1)./(tauM*z) - ...
                tauM^2*z/sqrt(pi).*NB);
        end
    end
% Convert for negative imag(z) values
FF(ind_neg) = conj(2*exp(-z(ind_neg).^2) - FF(ind_neg));
end