
--
-- prop_generic is the base for all other properties. 
-- All the business should be done in :Setup using inline functions.
-- So when you derive from this class - you should ideally only override Setup.
--

local PANEL = {}

AccessorFunc( PANEL, "m_pRow", "Row" )

function PANEL:Init()
end

function PANEL:Think()

	--
	-- Periodically update the value
	--
	if ( isfunction( self.m_pRow.DataUpdate ) ) then

		self.m_pRow:DataUpdate()

	end

end

--
-- Called by this control, or a derived control, to alert the row of the change
--
function PANEL:DoClick(self1)
	if ( isfunction( self.m_pRow.OnPress ) ) then
	
		self.m_pRow:OnPress(self1)

	end

end

function PANEL:Setup( vars )
	local name = self:GetRow().Label:GetText()
	self:Clear()
	self:GetRow().Label:Remove()
	local butt = self:Add( "DButton",self:GetRow())
	self:GetRow().Button = butt
	self:GetRow().Label = butt
	butt:SetDrawBackground( true )
	butt:Dock( FILL )
	butt:SetText(name)
	butt.DoClick = function(self1)
		self:DoClick(self1)
	end
	-- Return true if we're editing
	self.IsEditing = function( self )
		return false
	end
end

derma.DefineControl( "DProperty_Button", "", PANEL, "Panel" )
