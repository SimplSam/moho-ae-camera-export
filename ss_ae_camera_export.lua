
-- **************************************************
-- Provide Moho with the name of this script object
-- **************************************************

ScriptName = "SS_Ae_CameraExport"

--[[

    Derived work based on: 'DS Camera to AE v1.1' by
      (C) 2013 David F. Sandberg (aka. ponysmasher)
      https://www.dauid.com - with thanks

    Derived by: Sam Cogheil (SimplSam) 2022-Jan

    Primary Changes:
        - Save to Clipboard instead of file
        - Run as Menu or Button Tool (w/ PNG)
        - Optimize/Minimize: Keyframe-less properties
        - Functionalise

]]--

-- **************************************************
-- General information about this script
-- **************************************************

SS_Ae_CameraExport = {}
function SS_Ae_CameraExport:Name()
	return "SS/DS Camera to AE+"
end

function SS_Ae_CameraExport:Version()
	return "2.0 #520114"
end

function SS_Ae_CameraExport:Description()
	return "Export Camera data to Clipboard for After Effects"
end

function SS_Ae_CameraExport:Creator()
	return "dauid.com / SimplSam"
end

function SS_Ae_CameraExport:UILabel()
	return("Camera to AE+")
end


-- **************************************************
-- The guts of this script
-- **************************************************

function SS_Ae_CameraExport:Run(moho)

    local mohodoc = moho.document
    local width = mohodoc:Width()
    local height = mohodoc:Height()
    local aspect = mohodoc:AspectRatio()
    local newX = mohodoc:Width()/2
    local newY = mohodoc:Height()/2
    local newZ = mohodoc:Height()/2
    local fps = mohodoc:Fps()
    local startframe = mohodoc:StartFrame()
    local endframe = mohodoc:EndFrame()
    local zoomFactor = (1/ math.tan(math.pi/(2 * 6)))/2 * newZ  -- i.e. 3.7321 /2 *540 for 1080p
    local cliptext = {} --tabl

    local function AddText(s)
        table.insert(cliptext, s .."\r\n")
    end

    local function AddHead(s1, s2)
        AddText("\r\n" .. s1 .. "\r\n" .. s2)
    end

    local function ssRound4(n)
        return (LM.Round(n * 10^4)/10^4)
    end

    local function CallbackAngle(_val)
        return ssRound4(math.deg(_val))
    end

    local function CallbackAngleX(_val)
        return CallbackAngle(_val.x)
    end

    local function CallbackAngleY(_val)
        return CallbackAngle(_val.y)
    end

    local function CallbackZoom(_val)
        return ssRound4(_val * zoomFactor)
    end

    local function CallbackCamXYZ(_val, _zoffset)
        _zoffset = _zoffset or 0
        if (aspect >0) then
            _val.x = ((_val.x + 1) * newY) + newX -newY
            _val.y = (-_val.y + 1) * newY
            _val.z = (-_val.z * newZ) + _zoffset
        else
            _val.x = (_val.x + 1) * newX
            _val.y = ((-_val.y + 1) * newX) + newY -newX
            _val.z = (-_val.z * newX) + _zoffset
        end
        return ssRound4(_val.x) .."\t".. ssRound4(_val.y) .."\t".. ssRound4(_val.z)
    end

    local function CallbackCamXYZee(_val)
        return CallbackCamXYZ(_val, 0.1)
    end

    local function AddKeys(animChannel, Callback)
        local keyCount = animChannel:CountKeys()
        if (keyCount > 1) then
            local theend = math.min(animChannel:GetKeyWhen(keyCount -1), endframe)
            for i = startframe, theend do
                AddText("\t".. i .."\t".. Callback(animChannel:GetValue(i)) .."")
            end
        else
            AddText("\t\t".. Callback(animChannel:GetValue(0)) .."")
        end
    end

    --= Header
    AddText("Adobe After Effects 8.0 Keyframe Data")

    --= Doc props
    AddHead("\tUnits Per Second\t"..fps, "\tSource Width\t"..width)
    AddText("\tSource Height\t"..height)
    AddText("\tSource Pixel Aspect Ratio\t1")
    AddText("\tComp Pixel Aspect Ratio\t1")

    --= Zoom
    AddHead("Camera Options\tZoom", "\tFrame\tpixels")
    AddKeys(mohodoc.fCameraZoom, CallbackZoom)

    --= Point of interest (2 Node Cam)
    AddHead("Transform\tPoint of Interest", "\tFrame\tX pixels\tY pixels\tZ pixels")
    AddKeys(mohodoc.fCameraTrack, CallbackCamXYZee)

    --= Position
    AddHead("Transform\tPosition", "\tFrame\tX pixels\tY pixels\tZ pixels")
    AddKeys(mohodoc.fCameraTrack, CallbackCamXYZ)

    --= Z rotation
    AddHead("Transform\tRotation", "\tFrame\tdegrees")
    AddKeys(mohodoc.fCameraRoll, CallbackAngle)

    --= X rotation
    AddHead("Transform\tX Rotation", "\tFrame\tdegrees")
    AddKeys(mohodoc.fCameraPanTilt, CallbackAngleX) -- SS: Todo Split Dims?

    --= Y rotation
    AddHead("Transform\tY Rotation", "\tFrame\tdegrees")
    AddKeys(mohodoc.fCameraPanTilt, CallbackAngleY)

    --= Footer
    AddHead("", "End of Keyframe Data")

    --= Copy to Clipboard
    moho:CopyText(table.concat(cliptext))
end